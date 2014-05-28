$file = '/etc/passwd';		# Name the file
open(INFO, $file);		# Open the file
@lines = <INFO>;		# Read it into an array
close(INFO);			# Close the file
print @lines;			# Print the array
