
# used by autodeploy system, dont modify
import 'run_once.pp'

node default{}
node 'cnkaradev-it'{

        file { "C:\\test\\asdgas\\sadgsdg\dgedeg\dcd":
                 ensure => "directory",
        }
}
