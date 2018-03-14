## Package Manage ##
#Config, Depends, Explicit
alias pm='pacman' pmc='pacdiff' pmd='pm -D --asdeps' pme='pm -D --asexplicit'
#Fetch , Remove, Install, Update
alias pmf='asp export' pmr='pm -Rsn' pmi='pm -S' pmu='pm -Syu'
#makePkg, Fetch, Skip build, Install
alias pmp='makepkg -sci' pmpf='makepkg -o' pmps='makepkg -R' pmpi='pacman -U'

## Package  Query ##
alias pq='pm -Ss' 
#AUR, Belonged file, AUR Installed File
alias pqa='pm -Qem' pqb='pm -Fo' pqi='pm -Qe' pqf='pm -F -l'
#Depends, Required
pqd() {
	pm -Qi $1 | grep 'Depends On'
}
pqr() {
	pm -Qi $1 | grep 'Required By'
}
