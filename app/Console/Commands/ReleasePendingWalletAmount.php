<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use App\Models\Transaction;
use App\Models\Wallet;
use Carbon\Carbon;

class ReleasePendingWalletAmount extends Command
{
    protected $signature = 'wallet:release-pending';

    protected $description = 'Release pending wallet amounts after refund period';

    public function handle()
    {
        $this->info('⏳ Checking pending wallet transactions...');

        $transactions = Transaction::where('status', 'pending')
            ->whereNotNull('refundable_until')
            ->where('refundable_until', '<=', Carbon::now())
            ->get();

        if ($transactions->isEmpty()) {
            $this->info('✅ No pending transactions found.');
            return Command::SUCCESS;
        }

        DB::beginTransaction();

        try {
            foreach ($transactions as $tx) {

                $wallet = Wallet::where('profile_id', $tx->profile_id)
                    ->lockForUpdate()
                    ->first();

                if (!$wallet) {
                    continue;
                }

                // 🔄 Move pending → available
                $wallet->pending_amount   -= $tx->amount;
                $wallet->available_amount += $tx->amount;

                // 🔐 Safety check
                if ($wallet->pending_amount < 0) {
                    $wallet->pending_amount = 0;
                }

                $wallet->save();

                // Update transaction
                $tx->status = 'available';
                $tx->save();

                $this->info("✔ Released $".$tx->amount." for profile ID ".$tx->profile_id);
            }

            DB::commit();
            $this->info('🎉 All pending amounts released successfully.');

        } catch (\Exception $e) {
            DB::rollBack();
            \Log::error('Wallet cron failed: '.$e->getMessage());
            $this->error('❌ Cron failed.');
        }

        return Command::SUCCESS;
    }
}
