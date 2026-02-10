<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\User;
use App\Models\Goal;
use App\Models\GoalHistory;
use App\Models\Payment;
use App\Models\TemporaryWallet;
use App\Models\Wallet;
use App\Models\Tranasaction;
use Carbon\Carbon;
use Helper;

class RecurringPayment extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'recurring:payment';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
		try 
        {
            
        }
        catch(\Stripe\Exception\CardException $e) 
		{
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
// amount \
// date
// reason
// type {'dabit/cradit'}
// status
// user id
