# irb history
IRB.conf[:EVAL_HISTORY] = 10000
IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:HISTORY_FILE] = File::expand_path("~/.irbhistory")
