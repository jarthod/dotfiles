# irb history
IRB.conf[:USE_AUTOCOMPLETE] = false # quite buggy on ruby 3.1
IRB.conf[:EVAL_HISTORY] = 10000
IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:HISTORY_FILE] = File::expand_path("~/.irb_history")
