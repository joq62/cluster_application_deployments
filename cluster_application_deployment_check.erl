-module(cluster_application_deployment_check).

-export([
	 start/0,
	 %% Support
	 all_files/0,
	 all_info/0
	]).

 
-define(Dir,".").
-define(FileExt,".deployment").

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
start()->
    
    check(all_info()),
    init:stop(),
    ok.

check([])->
    io:format("Success, OK ! ~n");
check([{ok,[{cluster_application_deployment,_Id,Info}]}|T])->
    io:format("Checking ~p~n",[Info]),
    true=proplists:is_defined(cluster_spec,Info),
    true=proplists:is_defined(appl_deployment_specs,Info),
    check(T).

   

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
all_files()->
    {ok,Files}=file:list_dir(?Dir),
    FileNames=[filename:join(?Dir,Filename)||Filename<-Files,
					     ?FileExt=:=filename:extension(Filename)],
    FileNames.    
all_info()->
    [file:consult(File)||File<-all_files()].
	    
    
