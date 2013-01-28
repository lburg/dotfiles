task :install do
  # Intalls everything zsh related
  install_zsh_conf = true
  if File.exist?("#{ENV['HOME']}/.oh-my-zsh")
    puts "oh-my-zsh already installed."
  else
    install_zsh_conf = false
    print "Install oh-my-zsh? (y/n) "
    case $stdin.gets.chomp
    when 'y'
      puts "Installing oh-my-zsh..."
      result = system %[git clone git://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh]
      if result == true
        puts "Clone success."
        install_zsh_conf = true
      else
        puts "Failed to clone..."
      end
    when 'n'
      puts "oh-my-zsh was not installed."
    end
  end# if oh-my-zsh
  if install_zsh_conf == true
    puts "Installing zsh conf..."
    FileUtils.ln_s(Dir["#{Dir.pwd}/zsh/oh-my-zsh/custom/*"], "#{ENV['HOME']}/.oh-my-zsh/custom")
    FileUtils.ln_s("#{Dir.pwd}/zsh/zshrc", "#{ENV['HOME']}/.zshrc")
  end

  puts "Installing everything else..."
  files = Dir["*"] - %w"Rakefile zsh"
  # Symlinks everything else
  files.each do |dotfile|
    FileUtils.ln_s("#{Dir.pwd}/#{dotfile}", "#{ENV['HOME']}/.#{dotfile}")
  end
  puts "dotfiles intalled!"
end

task :default => :install
