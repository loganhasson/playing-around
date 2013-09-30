until Time.now.hour == 20 && Time.now.min == 59 && Time.now.wday == 0
  sleep(30)
end
system("say Its time for Homeland.")