#add timestamp to history file
export HISTTIMEFORMAT="%d/%m/%y %T "


#set timezone to BST
export TZ=Europe/London
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


#update bash profile with paths and aliases
cat << EOF >> /root/.bashrc
PATH=/opt/hmpps/proxy-scripts/:$PATH
PATH=/opt/hmpps/proxy-scripts/pre-prod:$PATH
PATH=/opt/hmpps/proxy-scripts/production:$PATH
PATH=/opt/hmpps/proxy-scripts/stage:$PATH

#source aliases
for f in /opt/hmpps/aliases/*.sh; do
   source "$$f" -H
done


EOF