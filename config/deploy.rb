# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

set :application, "Diving_Log"
set :repo_url, "git@github.com:hiiihaaa/Diving_Log.git"

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')  

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1' 
 # どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'], keys: ['~/.ssh/dl_d669859.pem']  
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }                       # プロセス番号を記載したファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }                # Unicornの設定ファイルの場所
set :keep_releases, 5
after 'deploy:publishing', 'deploy:restart'                                         # デプロイ処理が終わった後、Unicornを再起動するための記述
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
