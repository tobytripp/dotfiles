DC = "docker-compose"
DC_ENV = { "WORKING_DIR" => Dir.pwd }
def dc( *args )
  pid = spawn( DC_ENV, DC, *args )
  Process.wait pid
end

namespace :clojure do
  desc "Connect to a remote REPL instance, e.g., in a container"
  task :emacs, [:container] do |t, args|
    args.with_defaults container: :build
    pid = Process.spawn "bin/cider", container
    Process.detach pid
    dc "up", "-d", args[:container] rescue nil
    Process.waitall
  end
end
