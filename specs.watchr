def run(cmd)
  result = `#{cmd}`
  if result.include?('0 failures, 0 errors')
    `growlnotify -m "All green" --image ~/Downloads/rails_ok.png`
  else
    `growlnotify -m "OUCH!!" --image ~/Downloads/rails_fail.png`
  end
  puts result
end

watch('Rakefile')                 {|m| run "rake" }
watch('^lib/(.*)')                {|m| run "rake" }
watch('^spec/(.*)')               {|m| run "rake" }
