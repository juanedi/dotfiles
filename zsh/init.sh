####################################################
#
# Example of .zshrc/.bashrc:
#
# CONF_DIR=/Users/jedi/code/dotfiles/zsh
# [[ -s "$CONF_DIR/init.sh" ]] && . "$CONF_DIR/init.sh"
#
####################################################

# sufijo para archivos independientes del SO
global_suffix='_global.sh'

# sufijo para scripts dependientes del SO
linux_suffix='_linux.sh'
mac_suffix='_mac.sh'

os=`uname -s`
suffix='unknown'
if [[ "$os" == 'Linux' ]]; then
   suffix=$linux_suffix
elif [[ "$os" == 'Darwin' ]]; then
   suffix=$mac_suffix
fi

for f in $CONF_DIR/*.sh; do
    if [[ $f =~ .*$suffix$ || $f =~ .*$global_suffix$ ]]
    then
        source $f
    fi;
done
