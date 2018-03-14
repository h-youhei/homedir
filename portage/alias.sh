## Package Manage ##
#Config, fetch, Install, Log, Oneshot
alias pm='emerge' pmc='dispatch-conf' pmf='pm -f' pmi='pm -av' pml='eread' pmo='pm -1av' 
#Remove, sYnc, Update
alias pmr='pm --deselect' pmR='pm -a --depclean' pmy='eix-sync' pmu='pm -uDNav' pmU='pmu @world'

## Package Query ##
#Belonged_file, Changelog, Depend, dependGraph
alias pq='eix' pqb='equery belongs' pqc='equery change' pqd='equery depends' pqg='equery depgraph'
#File, Installed, New, Use, UseGlobal
alias pqf='equery files'  pqi='equery list' pqn='eix-diff' pqu='equery uses' pqug='euse -i -g' 

