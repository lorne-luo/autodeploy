# *** mkdir ***
# 2013.12.18 by Lorne

define mkdir( $path ) {
	if ! defined(File["$path"]) {
	   file { "$path": ensure => directory, mode => 777, }
	}
}
