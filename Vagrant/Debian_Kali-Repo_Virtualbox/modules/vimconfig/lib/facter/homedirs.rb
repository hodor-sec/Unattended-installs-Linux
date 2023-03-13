# collect home directories
Facter.add(:homedirs) do
  setcode do
    # grab home directories on system and convert into array
    `ls /home`.split("\n")
  end
end
