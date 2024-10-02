#!/usr/bin/env bash
echo "LastUpdate: 2024-10-02 rev1"
echo "Edited by Vincenzo Favara"
_bashrc_name="bashrc.sh"
echo "Script: ${0##*/}"
_bashrc_url="https://raw.githubusercontent.com/vivi7/dotfiles/master/bashrc.sh"
echo "Source $_bashrc_url \n"

_welcome_message="run 'funchelp' to List all sourced custom functions"

export red=$'\e[1;31m'
export green=$'\e[1;32m'
export yellow=$'\e[1;33m'
export blue=$'\e[1;34m'
export purple=$'\e[1;33m'
export cyan=$'\e[1;35m'
export white=$'\e[1;37m'
export endc=$'\e[0m'

_DESCRIPTIONS=()

_DESCRIPTIONS+=('funchelp: List all sourced custom functions.')
funchelp() {
    IFS=$'\n' sorted=($(sort <<<"${_DESCRIPTIONS[*]}"))
    unset IFS
    local index=1
    for description in "${sorted[@]}"; do
        printf "%d. %s\n" "$index" "$description"
        ((index++))
    done
}

_DESCRIPTIONS+=('echom: custom echo function')
echom() {
    message=$1 || "no_message"
    color=$3 || ${endc}
    point=$2 || "info"
    echo -e ${color}"\n[$point] $message\n"${endc}
}

_DESCRIPTIONS+=('checkOS: Print system OS')
checkOS() {
    unameOut="$(uname -a)"
    case "${unameOut}" in
    *Darwin*) machine=MacOS ;;
    *CYGWIN*) machine=Cygwin ;;
    *MINGW*) machine=MinGw ;;
    *iSH*) machine=iSH ;;
    *qnap*) machine=qnap ;;
    *synology*) machine=synology ;;
    *kali*) machine=kali ;;
    *parrot*) machine=parrot ;;
    *pop-os*) machine=popos ;;
    *Linux*) [ -x $(command -v termux-setup-storage) ] && machine=Termux || machine=Linux ;;
    *) machine="UNKNOWN:${unameOut}" ;;
    esac
    echo ${machine}
}
echo "check OS condition platform: $(checkOS)"
isMac() { [[ $(checkOS) == "MacOS" ]] && echo 1 || echo 0; }
isTermux() { [[ $(checkOS) == "Termux" ]] && echo 1 || echo 0; }
isIsh() { [[ $(checkOS) == "iSH" ]] && echo 1 || echo 0; }
isQnap() { [[ $(checkOS) == "qnap" ]] && echo 1 || echo 0; }
isSynology() { [[ $(checkOS) == "synology" ]] && echo 1 || echo 0; }
isKali() { [[ $(checkOS) == "kali" ]] && echo 1 || echo 0; }
isParrot() { [[ $(checkOS) == "parrot" ]] && echo 1 || echo 0; }
isPop() { [[ $(checkOS) == "pop-os" ]] && echo 1 || echo 0; }

export BLOCKSIZE=5k # Set default blocksize for ls, df,

_bashrc_file_path=~/.bashrc
_disk_to_show='/'

docker_volume_prefix="$HOME"
docker_volume_config_prefix="$docker_volume_prefix"

alias cd..='cd ../'                                                                                                          #: cd: Go back 1 directory level (for fast typers)
alias ..='cd ../'                                                                                                            #: ..: Go back 1 directory level
alias ...='cd ../../'                                                                                                        #: ..: Go back 2 directory levels
alias h='cd $HOME'                                                                                                           #: h: Go Home
alias q='exit'                                                                                                               #: q: exit
alias xxx='chmod +x'                                                                                                         #: xx: chmod +x
alias cp='cp -iv'                                                                                                            #: cp: implementation
alias mv='mv -iv'                                                                                                            #: mv: implementation
alias mkdir='mkdir -pv'                                                                                                      #: mkdir: implementation
alias ll='ls -FGlAhp'                                                                                                        #: ls: implementation
alias less='less -FSRXc'                                                                                                     #: less: implementation
alias c='clear'                                                                                                              #: c: Clear terminal display
alias path='echo -e ${PATH//:/\\n}'                                                                                          #: path: Show all executable Paths
alias cic='set completion-ignore-case On'                                                                                    #: cic: Make tab-completion case-insensitive
alias cpv='rsync -ahv --info=progress2'                                                                                      #: cpv: Copy wirt progress
alias qfind="find . -name "                                                                                                  #: qfind: Quickly search for file
alias sizer='du -sh * | sort -n -r'                                                                                          #: sizer: Folder size ordered
alias numFiles='echo $(ls -1 | wc -l)'                                                                                       #: numFiles: Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat'                                                                                          #: make1mb: Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'                                                                                          #: make5mb: Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'                                                                                       #: make10mb: Creates a file of 10mb size (all zeros)
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"                                                              #: cleanupDS: Recursively delete .DS_Store files
alias cleanup_s="find . -type f -name '._*' -ls -delete"                                                                     #: cleanup_s: Recursively delete ._* files
alias cleanupGit="( find . -type d -name ".git" && find . -name ".gitignore" && find . -name ".gitmodules" ) | xargs rm -rf" #: cleanupGit: Recursively delete all .git files
alias memHogsTop='top -l 1 -o rsize | head -20'                                                                              #: memHogsTop: Find memory hogs
alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'                                                     #: memHogsPs: Find memory hogs
alias cpuHogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'                                                            #: cpuHogs: Find CPU hogs
alias topForever='top -l 9999999 -s 10 -o cpu'                                                                               #: topForever:  Continual 'top' listing (every 10 seconds)
alias ttop="top -R -F -s 10 -o rsize"                                                                                        #: ttop:  Recommended 'top' invocation to minimize resources
alias psmem='ps auxf | sort -nr -k 4'                                                                                        #: psmem: get top process eating memory
alias psmem10='ps auxf | sort -nr -k 4 | head -10'                                                                           #: psmem: get top process eating memory for first 10
alias pscpu='ps auxf | sort -nr -k 3'                                                                                        #: pscpu: get top process eating cpu
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'                                                                           #: pscpu10: get top process eating cpu for first 10
alias ports='sudo lsof -PiTCP -sTCP:LISTEN'                                                                                  #: ports: show ports in listen status

_DESCRIPTIONS+=('setps1: Set custom PS1.')
setps1() {
    PS1='\[${usercolor}\]┌─╼ λ\[${endc}\] \[${blue}\w\[${endc}\] \[${purple}$(git branch 2>/dev/null | grep "^*")\[${endc}\] \[${usercolor}\]$\[${endc}\] \[${usercolor}\]\n└──────► \[${endc}\]'
}

_DESCRIPTIONS+=('update_bashrc: Download bashrc.sh from repo in current folder. You can use a custom name as $1 arg.')
update_bashrc() {
    filename="${1:-$_bashrc_name}"
    curl -o "$filename" "$_bashrc_url"
}

_DESCRIPTIONS+=('_copy: copy to clipboard')
_copy() { cat | xclip -selection clipboard; }

_DESCRIPTIONS+=('_paste: paste from clipboard')
_paste() { xclip -selection clipboard -o; }

_DESCRIPTIONS+=('calcp: calculate percent passing 3 args, example: calcp x 10 7 && calcp 70 x 7 && calcp 70 10 x')
calcp() {
    awk -v a="$1" -v b="$2" -v c="$3" -v perc="%" 'BEGIN {
        if ( a == "x" ) printf "%.2f%s of %.2f is %.2f\n", c * 100 / b, "%", b, c
        else if( b == "x" ) printf "%.2f%s of %.2f is %.2f\n", a, "%", 100 / a * c, c
        else if( c == "x" ) printf "%.2f%s of %.2f is %.2f\n", a, "%", b, a * b / 100
        else print "Pass 3 args:\nExample: x of 10 is 7 ====> 70%\nExample: 70% of x is 7 ====> 10\nExample: 70% of 10 is x ====> 7"
    }'
}
_DESCRIPTIONS+=('encrypt: encrypt file $1 to $2')
encrypt() { openssl des3 -in "$1" -out "$2"; }

_DESCRIPTIONS+=('decrypt: decrypt file $1 to $2')
decrypt() { openssl des3 -d -in "$1" -out "$2"; }

_DESCRIPTIONS+=('remove_ssh_key_for_ip: Remove ssh key for provided ip')
remove_ssh_key_for_ip() { ssh-keygen -R "$1"; }

_DESCRIPTIONS+=('rename_spaces: Replace all spaces with underscores for all files in folder')
rename_spaces() { for f in *\ *; do mv "$f" "${f// /_}"; done; }

_DESCRIPTIONS+=('nomedia: create .nomedia file or remove if exist as toggle')
nomedia() { [ -f ".nomedia" ] && { rm .nomedia; } || { touch .nomedia; }; }

_DESCRIPTIONS+=('findpid: find out the pid (by also regex) of a specified process')
findpid() { lsof -t -c "$@"; }

_DESCRIPTIONS+=('myps: List processes owned by my user')
myps() { ps "$@" -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command; }

_DESCRIPTIONS+=('ippub: Public IP Address')
ippub() { curl ifconfig.co 2>/dev/null; }

_DESCRIPTIONS+=('ipswifi: Wlan IP Address')
ipswifi() { ifconfig | grep 'inet ' | grep -v 127.0.0.1 | awk '{print $2}'; } # ifconfig | awk '/inet / && !/127.0.0.1/ {print $2}'

_DESCRIPTIONS+=('ipgatewifi: Wlan IP Address')
ipgatewifi() { ip route | grep default | awk '{print $3;}'; }

_DESCRIPTIONS+=('ipparent: Wlan IP parent')
ipparent() { ip route | grep default | awk '{print $5;}'; }

_DESCRIPTIONS+=('httpHeaders: Grabs headers from web page')
httpHeaders() { curl -I -L "$@"; }

_DESCRIPTIONS+=('httpDebug: Download a web page and show info on what took time')
httpDebug() { curl "$@" -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n"; }

_DESCRIPTIONS+=('cd: Always list directory contents upon '\''cd'\''')
cd() { builtin cd "$@" && ll; }

_DESCRIPTIONS+=('mv_subfiles_here: Move subdirectories files here')
mv_subfiles_here() { find . -type f -print0 | xargs -0 mv -t .; }

_DESCRIPTIONS+=('mcd: Makes new Dir and jumps inside')
mcd() { mkdir -p "$1" && cd "$1"; }

_DESCRIPTIONS+=('ff: Find file under the current directory')
ff() { find . -name "$@"; }

_DESCRIPTIONS+=('ffi: Find images here')
ffi() { find ./ -type f -exec file --mime-type {} \; | awk '{if ($NF ~ "image") print $0 }'; }

_DESCRIPTIONS+=('cchown: Change user Owner')
cchown() { [[ $(id -u) -ne 0 ]] && { sudo chown -R $(whoami) "$1"; } || { chown -R $(whoami) "$1"; }; }

_DESCRIPTIONS+=('zipf: To create a ZIP archive of a folder')
zipf() { zip -r "$1".zip "$1"; }

_DESCRIPTIONS+=('gitbranch: print git branch')
gitbranch() { git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/@\1 /'; }

_DESCRIPTIONS+=('addpath: add safety path to PATH var, use -s as $2 to no logs')
addpath() {
    path_to_add="$1"
    silent="$2"
    if [[ ! -d "$path_to_add" ]]; then
        [[ "$silent" != "-s" ]] && { echom "$path_to_add not exist" "!" "${red}"; }
    elif [[ ":$PATH:" == *":$path_to_add:"* ]]; then
        [[ "$silent" != "-s" ]] && { echom "$path_to_add already added" "-" "${yellow}"; }
    else
        PATH="${PATH:+"$PATH:"}$path_to_add" && [[ "$silent" != "-s" ]] && { echom "$PATH" "*" "${green}"; }
    fi
}

_DESCRIPTIONS+=('load_envs: Load .env files given a path or in the run dir')
load_envs() {
    _path="${1:-"."}"
    find "$_path" -maxdepth 1 -name '*.env' -print | while read env; do source "$env"; done
}

_DESCRIPTIONS+=('extract: Extract most known archives with one command')
extract() {
    if [ -f $1 ]; then
        case $1 in
        *.tar.bz2) tar xjf $1 ;;
        *.tar.gz) tar xzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar e $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xf $1 ;;
        *.tbz2) tar xjf $1 ;;
        *.tgz) tar xzf $1 ;;
        *.zip) unzip $1 ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *.*) echo "$1 cannot be extracted via extract" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

_DESCRIPTIONS+=('extract_combine: Extract and combine zip files starting with given name')
extract_combine() {
    NAME="${1}"
    mkdir -p "${NAME}"
    find . -name "${NAME}*.zip" -print0 | sort -zk 1nr | while read -d $'\0' archive; do
        echom "Unzipping $archive" "*" "${yellow}"
        unzip "$archive" -d "${NAME}"
    done
}

_DESCRIPTIONS+=('join_files: Join files contained into a provided folder')
join_files() {
    folder="${1}" || "."
    file_output="joined.txt"
    function join_files() {
        file_input="$1"
        echo $file_input
        if [ -s "$file_input" ]; then
            echo "" >>"$file_output"
            echo "------------------------------------------------------------------------------------" >>"$file_output"
            echo "$file_input" >>"$file_output"
            echo "" >>"$file_output"
        fi
        cat "$file_input" >>"$file_output"
    }
    echo "" >"$file_output"
    files=($(find "$folder" -type f))
    for file in "${files[@]}"; do
        join_files "$file"
    done

    echo "Done in: $file_output"
}

_DESCRIPTIONS+=('clear_history_line: $1 || 1 ; Delete last line of bash history')
clear_history_line() {
    last=$1 || 1
    pos=$HISTCMD
    start=$(($pos - ${last}))
    end=$(($pos - 1))
    for i in $(eval echo "{${start}..${end}}"); do history -d $start; done
}

_DESCRIPTIONS+=('fcll: File and content in dir and subdir')
fcll() {
    for fullfile in $(find . -type f); do
        fullfilename=$(basename -- "$fullfile")
        extension="${fullfilename##*.}"
        filename="${fullfilename%.*}"
        echo "------------------------------------------------------"
        echo $filename
        cat $fullfile
        echo ''
    done
}

_DESCRIPTIONS+=('remove_line_contains: args: pattern filepath_or_folder')
remove_line_contains() {
    pattern="${1}"
    file_regex="${2}"
    folder="${3}"
    for path in $(find $folder -name $file_regex); do
        echo $path
        while read -r line; do [[ ! "$line" =~ "$pattern" ]] && echo "$line"; done <$path >$dest
        # mv $dest $path
    done
}

_DESCRIPTIONS+=('recurse_func: Recursively apply a function to files in a directory')
recurse_func() {
    __path="${1}"
    shift #args shift after first
    if [ -d "$__path" ]; then
        for __sub_path in "$__path/"*; do
            recurse_func "${@}" "${__sub_path}"
        done
    elif [ -f "$__path" ]; then
        "${@}" "$__path"
    fi
}

_DESCRIPTIONS+=('mytree: Display directory tree, with option to exclude folders')
mytree() {
    local dir="${1:-.}"
    shift
    exclude_args=""
    for folder in "$@"; do
        exclude_args+=" -path \"$dir/$folder\" -prune -o"
    done
    eval find "$dir" $exclude_args" -print" | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
}

_DESCRIPTIONS+=('repeat_cmd_in_folder: args: single_word_command_or_function folder1 folder2 ....')
repeat_cmd_in_folder() {
    cmd_to_repeat=${1}
    shift #args shift after first
    [ "${@}" ] && {
        folders_to_walk=("${@}")
        echo "args"
    } || {
        folders_to_walk=($(ls .))
        echo "ls"
    }
    for f in "${folders_to_walk[@]}"; do
        echom "Executing cmd $cmd_to_repeat in folder: $f" "*" "${yellow}"
        if [ -d "$f" ]; then
            cd $f
            $cmd_to_repeat
            cd ..
        else
            echom "$f is NOT folder" "!" "${red}"
        fi
    done
}

_DESCRIPTIONS+=('create_script: create template for new_script.sh')
create_script() {
    echo "${_new_script}" >new_script.sh
    chmod u+x new_script.sh
}

_DESCRIPTIONS+=('install_zsh: install and set zsh shell')
install_zsh() {
    echo "Do you want to install zsh? (y/n) : "
    read ZSH_REPLY
    [[ "$ZSH_REPLY" =~ "y" ]] && {
        mkdir -p $HOME/.oh-my-zsh
        git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
        cchown .oh-my-zsh
        # git clone https://github.com/zdharma/fast-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
        git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-completions $HOME/.oh-my-zsh/custom/plugins/zsh-completions
        # git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

        git clone https://github.com/denysdovhan/spaceship-prompt.git $HOME/.oh-my-zsh/custom/themes/spaceship-prompt --depth=1
        ln -s "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/themes/spaceship.zsh-theme"
        # npm install -g spaceship-prompt
        # cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc

        echo "Do you want to new setting on your .zshrc? (y/n) : "
        read ZSHRC_REPLY
        [[ "$ZSHRC_REPLY" =~ "y" ]] && {
            echo "${_zshrc}" >$HOME/.zshrc
            echom ".zshrc replaced" "*" "${green}"
            echo "source $_bashrc_file_path" >>$HOME/.zshrc
        }
        chsh -s zsh
    }
}

_DESCRIPTIONS+=('bitbucket_store: store all files in folder as bitbucket repo')
bitbucket_store() {
    REPO_NAME=$1
    ASWER_ALWAYS_YES=$2 || "n"
    ORIGIN=origin
    if [ -z "$REPO_NAME" ]; then
        REPO_NAME=$(basename $(pwd | sed 's/ /_/g' | tr A-Z a-z)) # Remove spaces from repository name and convert to lowercase
    fi
    if [ ! -d .git ]; then
        echom "No Git repository inside this directory. do you want to create? yes|no" "*" "${yellow}"
        [[ "$ASWER_ALWAYS_YES" == "n" ]] && { read GIT_REPLY; } || {
            GIT_REPLY="y"
            echo "yes"
        }
        if [[ "$GIT_REPLY" =~ "y" ]]; then
            git init && git add . && git commit -m "initial commit"
        else
            echom "Cancelled." "*" "${yellow}"
            return
        fi
    fi
    if [[ $(git remote -v | grep bitbucket.org) == "0" ]]; then
        echom "Repository already has a BitBucket remote" "!" "${red}"
        return
    fi
    if [[ $(git remote | grep origin) == "origin" ]]; then
        echom "Repository already has an 'origin' remote, use bb-origin" "!" "${red}"
        ORIGIN="bb-origin"
    fi
    if [ -z "$BB_USER" ]; then
        local BB_USER
        echo "Enter BitBucket User name - avoid this by setting BB_USER env variable"
        read BB_USER
    fi
    if [ -z "$BB_PASSWORD" ]; then
        local BB_PASSWORD
        echo "Enter BitBucket password - WARNING: will be displayed in clear text"
        echo "Avoid this by setting the BB_PASSWORD env variable"
        read BB_PASSWORD
    fi
    echom "Creating Repository $REPO_NAME, do you want to continue? yes|no" "*" "${green}"
    [[ "$ASWER_ALWAYS_YES" == "n" ]] && { read CREATE_REPO_REPLY; } || {
        CREATE_REPO_REPLY="y"
        echo "yes"
    }
    if [[ "$CREATE_REPO_REPLY" =~ "y" ]]; then
        BB_RESPONSE=$(curl -f -X POST -u $BB_USER:$BB_PASSWORD -H "Content-Type: application/json" \
            https://api.bitbucket.org/2.0/repositories/$BB_USER/$REPO_NAME \
            -d '{"scm": "git", "is_private": "true", "fork_policy": "no_public_forks" }' -o /dev/null -w '%{http_code}') | grep "HTTP*" | awk {'print $2'}
        [[ "$BB_RESPONSE" == "22" ]] && {
            echo "REST Call to BitBucket failed. Repository has not been created."
            return
        }
    fi
    echom "Add remote $ORIGIN and push to $REPO_NAME" "*" "${green}"
    git remote add $ORIGIN https://$BB_USER@bitbucket.org/$BB_USER/$REPO_NAME.git
    git push -u $ORIGIN --all
    echom "Done. You can find your new repository here: https://bitbucket.org/$BB_USER/$REPO_NAME" "*" "${green}"
}

_DESCRIPTIONS+=('config_git: replace your .gitconfig')
config_git() {
    echo "Do you want to replace your .gitconfig? (y/n) : "
    read GITCONFIG_REPLY
    [[ "$GITCONFIG_REPLY" =~ "y" ]] && {
        echo "${_git_config}" >$HOME/.gitconfig
        echom ".gitconfig replaced" "*" "${green}"
    }
}

_DESCRIPTIONS+=('vdiff: compare 2 files/folders')
vdiff() {
    if [ "${#}" -ne 2 ]; then
        echo "vdiff requires two arguments"
        echo "  comparing dirs:  vdiff dir_a dir_b"
        echo "  comparing files: vdiff file_a file_b"
        return 1
    fi
    left="${1}"
    right="${2}"
    if [ -d "${left}" ] && [ -d "${right}" ]; then
        vim +"DirDiff ${left} ${right}"
    else
        vim -d "${left}" "${right}"
    fi
}

_DESCRIPTIONS+=('decrease_quality_image: Decrease image quality to 90%')
decrease_quality_image() {
    _regex=$1 || '*.jpg'
    mogrify -path ./ -strip -quality 90% $_regex
}

_DESCRIPTIONS+=('install_vscode_ext: Install extension for vscode')
install_vscode_ext() {
    code --install-extension esbenp.prettier-vscode
    code --install-extension CoenraadS.bracket-pair-colorizer-2
    code --install-extension darkriszty.markdown-table-prettify
    code --install-extension eamodio.gitlens
    code --install-extension esbenp.prettier-vscode
    code --install-extension sketchbuch.vsc-quokka-statusbar
    code --install-extension TabNine.tabnine-vscode
    code --install-extension vscode-icons-team.vscode-icons
    code --install-extension WallabyJs.quokka-vscode
    code --install-extension wix.vscode-import-cost
    code --install-extension wmaurer.change-case
    code --install-extension rangav.vscode-thunder-client
    code --install-extension Shan.code-settings-sync
}

_DESCRIPTIONS+=('heic2jpg: convert heic to jpj in folder')
heic2jpg() {
    if ! command -v convert &>/dev/null; then
        echo "Error: ImageMagick is not installed. Please install it and try again."
        exit 1
    fi
    IN_EXT="${1:-HEIC}"
    echo "Do you want to delete .heic files after conversion? (y/n) : "
    read DEL_REPLY
    [[ "$DEL_REPLY" =~ "y" ]] && { TO_DEL=1; }
    for file in *.$IN_EXT; do
        filename="${file%.*}"
        convert "$file" "${filename}.jpg"
        [[ $TO_DEL == 1 ]] && { rm "$file"; }
    done
}

_DESCRIPTIONS+=('wrap_ffmpeg: -i mov -o mp4 -j , wrap_ffmpeg -h for help')
wrap_ffmpeg() { #: wrap_ffmpeg: -i mov -o mp4 -j
    [ -x $(command -v ffmpeg) ] || {
        echom "I require ffmpeg but it's not installed." "!" "${red}"
        exit 1
    }
    usage() {
        echom "\nUsage: $PROGNAME [-v] [-d <dir>] [-f <file>] \n
            -i <file_input>: Specify file input path
            -o <file_output>: Specify file output path
            -t <metadata_title>: Write custom title OR put 'file' arg if you want metadata title should be equal to new filename
            -j <to_join>: Put it in if you want to join files, input and output formats should be equal
            -d <delete_source>: Put it in if you want to source file
            -l <list_info>: Put it to have only selected info of all video (info: all|streams|format|title)
            -m <maxdepth>: Put maxdepth number to go deep in folder (default: 1)
            \nfor f in *.mkv; do ffmpeg -i "\$f" -qscale 0 -map 0:v -map 0:a "\${f%.mkv}.mp4"; done;
            \nExample reduce quality: ffmpeg -i file.mp4 -vf "scale=iw/2:ih/2" -c:v libx264 -b:a 48k JOINED.mp4" "!" "${red}"
        return
    }
    inputFormat="mp4"
    outputFormat="mp4"
    to_join="n"
    metadata_title="n"
    delete_source="n"
    list_info="n"
    maxdepth=1
    while getopts 'i:o:jdt:l:m:' o; do
        case $o in
        i) inputFormat=$OPTARG ;;
        o) outputFormat=$OPTARG ;;
        t) metadata_title=$OPTARG ;;
        j) to_join="y" ;;
        d) delete_source="y" ;;
        l) list_info=$OPTARG ;;
        m) maxdepth=$OPTARG ;;
        *) usage ;;
        esac
    done
    shift "$((OPTIND - 1))"
    # echo Remaining arguments: "$@"

    arrToConcat=()
    # find . -maxdepth $maxdepth -iname "*.$inputFormat" -print0 | while IFS= read -r -d '' videoname; do # to fix loop ffmpeg
    # for videoname in $(find . -maxdepth $maxdepth -iname "*.$inputFormat" -print0); do # to fix spaces
    for videoname in ./*.$inputFormat; do
        OLD_PATH_NAME="${videoname// /%20}"
        VIDEO_PATH_EXT="${videoname##*.}"
        VIDEO_FULL_NAME=${videoname##*/}
        VIDEO_NAME=${VIDEO_FULL_NAME%.*}
        NEW_PATH_NAME=${videoname%.$inputFormat}.$outputFormat
        existing_metadata_json=$(ffprobe "${videoname}" -hide_banner -print_format json -v error -show_format -show_streams)
        existing_metadata_streams=$(echo $existing_metadata_json | jq -r .streams)
        existing_metadata_format=$(echo $existing_metadata_json | jq -r .format)
        existing_metadata_title=$(echo $existing_metadata_json | jq -r .format.tags.title | grep -v null)

        if [[ $metadata_title == "n" ]]; then
            metadata_title_to_replace=${existing_metadata_title}
        elif [[ $metadata_title == "file" ]]; then
            metadata_title_to_replace=${VIDEO_NAME}
        else
            metadata_title_to_replace=${metadata_title}
        fi

        inner_convert_to_mp4() {
            echom "Converting to MP4, Metadata_title to replace: ${metadata_title_to_replace}" "*" "${cyan}"
            ffmpeg -i "${videoname}" -metadata title="${metadata_title_to_replace}" -vcodec h264 -acodec aac "${NEW_PATH_NAME}"
        }

        inner_convert_others() {
            echom "Converting to OTHERS, Metadata_title to replace: ${metadata_title_to_replace}" "*" "${cyan}"
            ffmpeg -i "${videoname}" -metadata title="${metadata_title_to_replace}" -f $outputFormat "${NEW_PATH_NAME}"
        }

        inner_convert_copy() {
            echom "Replacing source with creating COPY, Metadata_title to replace: ${metadata_title_to_replace}" "*" "${cyan}"
            ffmpeg -i "${videoname}" -metadata title="${metadata_title_to_replace}" -codec copy "${VIDEO_NAME}.${VIDEO_PATH_EXT}.${VIDEO_PATH_EXT}"
            mv -vf "${VIDEO_NAME}.${VIDEO_PATH_EXT}.${VIDEO_PATH_EXT}" "${VIDEO_NAME}.${VIDEO_PATH_EXT}"
        }

        [[ $to_join == "y" ]] && {
            echo "to_join: yes" "*" "${cyan}"
            arrToConcat+=($OLD_PATH_NAME)
        }

        if [[ $list_info != "n" ]]; then
            case $list_info in
            all) echo "Existing ${videoname} metadata info: $existing_metadata_json" ;;
            streams) echo "Existing ${videoname} metadata .streams: $existing_metadata_streams" ;;
            format) echo "Existing ${videoname} metadata .format: $existing_metadata_format" ;;
            title) echo "Existing ${videoname} metadata .format.tags.title: $existing_metadata_title" ;;
            *)
                echo "-l arg need to be one of:"
                usage
                ;;
            esac
        elif [[ ! -f "${NEW_PATH_NAME}" ]] && [[ $inputFormat != $outputFormat ]]; then
            echo "CODING TO $outputFormat ON...: ${videoname}" "*" "${purple}"
            if [[ $outputFormat == "mp4" ]]; then
                inner_convert_to_mp4
            else
                inner_convert_others
            fi

            [[ $delete_source == "y" ]] && {
                echo "deleting...: ${videoname}" "!" "${red}"
                rm ${videoname}
            }

        elif ([[ -f "${NEW_PATH_NAME}" ]] || [[ $inputFormat == $outputFormat ]]) && [[ $metadata_title != "n" ]]; then
            [[ ${existing_metadata_title} != ${metadata_title_to_replace} ]] && { inner_convert_copy; } || { echo "${videoname} metadata title is already equal to file name"; }
        fi
    done

    [[ $to_join == "y" ]] && {
        echom "Joining..." "*" "${yellow}"
        touch _list_file_$inputFormat.txt
        for fiileToConcat in "${arrToConcat[@]}"; do
            echo "file '""${fiileToConcat//%20/ }""'" >>_list_file_$inputFormat.txt
        done
        ffmpeg -safe 0 -f concat -i _list_file_$inputFormat.txt -c copy joined.$outputFormat
        cat _list_file_$inputFormat.txt
        rm _list_file_$inputFormat.txt
        echom "Joined Successfully" "*" "${green}"
    }
}

_DESCRIPTIONS+=('docker-container-by-image: get docker container by image')
docker-container-by-image() {
    docker ps -a -q --filter ancestor=${1} --format="{{.ID}}" #tag
    docker ps -a | awk -v i="^$1.*" '{if($2~i){ print $1 }}'  #name
    for im in $(docker images -f "dangling=true" | awk '{ print $3 }' | tail -n +2); do docker ps -a | awk -v i=${im} '{if($2~i){ print $1 }}'; done
}

_DESCRIPTIONS+=('dockerrm: docker stop and remove')
dockerrm() {
    # docker stop $1 && docker rm $1
    docker rm $(docker stop ${1})
}

_DESCRIPTIONS+=('dockerrun: run docker app -it')
dockerrun() {
    docker run --rm -it -v "${PWD}":/app -w /app
}

_DESCRIPTIONS+=('dockernets: inspect net ips with their containers')
dockernets() {
    docker network inspect -f '{{.Name}} ({{.Driver}}) {{if .IPAM.Config}}{{.IPAM.Config}}{{else}}No ipam configs{{end}} {{range .Containers}}{{println}}    {{.Name}} {{.IPv4Address}} {{else}}{{println}}    No containers {{end}}{{println}}' $(docker network ls --format "{{.ID}}" | awk '{ print $1}')
}

_DESCRIPTIONS+=('dockertags: retrieve remote docker images tags')
dockertags() {
    image="${1}"
    wget -q "https://registry.hub.docker.com/v1/repositories/${image}/tags" -O - | tr -d '[]" ' | tr '}' '\n' | awk -F: '{print $3}'
}

_DESCRIPTIONS+=('dockersearch: search in docker hub')
dockersearch() {
    txt="${1}"
    wget -q "https://hub.docker.com/api/content/v1/products/search/?q=${txt}" -O - | jq -r '.summaries[] | [.id, .slug]'
}

_DESCRIPTIONS+=('check_docker: Check Synology docker permission instance')
check_docker() {
    if [[ ! $(cat /etc/group | grep docker) =~ $USER ]]; then
        echo -e "
        Creating docker group, adding $USER into it and changing docker.sock owner
        If you get again issue please run follow command:
            sudo chown root:administrators /var/run/docker.sock"
    fi
}

_DESCRIPTIONS+=('dockermacvlan: Create MacVLan network as the host one')
dockermacvlan() {
    check_docker
    docker network ls | grep VLAN_NAS >/dev/null || {
        docker network create \
            --driver=macvlan \
            --gateway=$(ipgatewifi) \
            --subnet=$(ipgatewifi | awk '{print substr($1, 1, length($1)-1);}')0/24 \
            --ip-range=$(ipgatewifi | awk '{print substr($1, 1, length($1)-1);}')254/32 \
            -o parent=$(ipparent) \
            VLAN_NAS
    }
    docker inspect VLAN_NAS
}

_DESCRIPTIONS+=('dockerwatch: Container with watchtower that watch docker instance and update the images if there are new ones')
dockerwatch() {
    check_docker
    docker run --detach --name watchtower \
        -v /var/run/docker.sock:/var/run/docker.sock \
        containrrr/watchtower
    docker ps
}

_DESCRIPTIONS+=('dockerportainer: Container with portainer-ce')
dockerportainer() {
    check_docker
    docker run --detach --name portainer-ce \
        -p 8000:8000 \
        -p 9000:9000 \
        --restart=always \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v portainer-ce_data:/data \
        portainer/portainer-ce \
        --admin-password=$PORTAINER_ADMIN_PASSWORD
    docker ps
}

_DESCRIPTIONS+=('dockertdd: Container with telegram-download-daemon')
dockertdd() {
    mkdir -p $docker_volume_prefix/Downloads/Telegram
    check_docker
    docker run --detach --name telegram-download-daemon \
        -v $docker_volume_prefix/Downloads/Telegram:/telegram-downloads \
        -e TELEGRAM_DAEMON_API_ID=$TELEGRAM_DAEMON_MAIN_API_ID \
        -e TELEGRAM_DAEMON_API_HASH=$TELEGRAM_DAEMON_MAIN_API_HASH \
        -e TELEGRAM_DAEMON_CHANNEL=$TELEGRAM_DAEMON_MAIN_CHANNEL \
        -e TELEGRAM_DAEMON_BOT_TOKEN=$TELEGRAM_DAEMON_MAIN_BOT_TOKEN \
        -e PUID=${UID} \
        -e PGID=${GID} \
        vivi7/telegram-download-daemon:latest
    docker ps
}

_DESCRIPTIONS+=('dockertddc: Container with telegram-download-daemon cc')
dockertddc() {
    mkdir -p $docker_volume_prefix/system_files/ccc
    check_docker
    docker run --detach --name tdd-ccc \
        -v $docker_volume_prefix/system_files/ccc:/telegram-downloads \
        -e TELEGRAM_DAEMON_API_ID=$TELEGRAM_DAEMON_CC_API_ID \
        -e TELEGRAM_DAEMON_API_HASH=$TELEGRAM_DAEMON_CC_API_HASH \
        -e TELEGRAM_DAEMON_CHANNEL=$TELEGRAM_DAEMON_CC_CHANNEL \
        -e TELEGRAM_DAEMON_BOT_TOKEN=$TELEGRAM_DAEMON_CC_BOT_TOKEN \
        -e PUID=${UID} \
        -e PGID=${GID} \
        vivi7/telegram-download-daemon:latest
    docker ps
}

_DESCRIPTIONS+=('dockertdlfb: Container with telegram-dtlkfb-bot')
dockertdlfb() {
    mkdir -p $docker_volume_prefix/DWeb/DataleakFB
    check_docker
    docker run --detach --name DataleakFB-bot \
        --restart=always \
        -v $docker_volume_prefix/DWeb/DataleakFB:/resources \
        -e TELEGRAM_BOT_TOKEN=$TELEGRAM_DATALAKEFB_BOT_TOKEN \
        -e PUID=${UID} \
        -e PGID=${GID} \
        vivi7/telegram-dtlkfb-bot:latest
    docker ps
}

_DESCRIPTIONS+=('dockerchormejdownloader: Container with jdownloader and chrome')
dockerchormejdownloader() {
    mkdir -p $docker_volume_config_prefix/jdownloader/folderwatch
    docker run --detach --name chrome-jdownloader-2 \
        --restart always \
        -v $docker_volume_prefix/Downloads/jdownloader:/usr/jd2/@download \
        -e TZ=Europe/Rome \
        -e LANG=it_IT.UTF-8 \
        -e LANGUAGE=it_IT \
        -e LC_ALL=it_IT.UTF-8 \
        -e DISPLAY=:0 \
        -e VNC_PORT=5900 \
        -e VNC_PW=$JDOWNLOADER_VNC_PASSWORD \
        -e RESOLUTION=1280x768x16 \
        -e JDOWNLOADER2_AUTO_START=yes \
        -e JDOWNLOADER2_AUTO_RESTART=yes \
        -p 5900:5900 \
        -e PUID=$(id -u ${USER}) \
        -e PGID=$(id -g ${USER}) \
        --network VLAN_NAS \
        --ip "$(ipgatewifi | awk '{print substr($1, 1, length($1)-1);}')253" \
        raykuo/chrome-jdownloader2
    docker ps
}

_DESCRIPTIONS+=('dockermega: Container with Mega client')
dockermega() {
    mkdir -p $docker_volume_prefix/Downloads/Mega
    docker run --detach --name MegaDL \
        --restart always \
        -v $docker_volume_prefix/Downloads/Mega:/output \
        -v mega_config:/config \
        -e VNC_PASSWORD=$MEGA_VNC_PASSWORD \
        -p 5800:5800 \
        -p 5900:5900 \
        -e PUID=$(id -u ${USER}) \
        -e PGID=$(id -g ${USER}) \
        --network VLAN_NAS \
        --ip "$(ipgatewifi | awk '{print substr($1, 1, length($1)-1);}')252" \
        gauravsuman007/megabasterd
    docker ps
}

_DESCRIPTIONS+=('dockervscode: Container with vscode')
dockervscode() {
    mkdir -p $docker_volume_config_prefix/CodeServer/config/code-server
    check_docker
    docker run --detach \
        --name code-server \
        --privileged \
        -h codeserver \
        -v data:/data \
        -v $docker_volume_config_prefix/CodeServer/config:/home/coder/.config \
        -v $docker_volume_prefix/Workspaces:/home/WS \
        -v data:/home/.local/share/code-server \
        -p 3991:8080 \
        -e TZ=Europe/Rome \
        -e PASSWORD=password \
        -e HASHED_PASSWORD= \
        -e SUDO_PASSWORD=$VSCODE_VNC_PASSWORD \
        -e SUDO_PASSWORD_HASH= \
        -e DEFAULT_WORKSPACE=/home/WS \
        -e PUID=${UID} \
        -e PGID=${GID} \
        --network VLAN_NAS \
        --ip "$(ipgatewifi | awk '{print substr($1, 1, length($1)-1);}')251" \
        codercom/code-server:latest
    docker ps
}

_DESCRIPTIONS+=('get_system_info: Display detailed system information in a formatted output')
get_system_info() {
    _OS="$(checkOS) - $(uname -a)"
    UPTIME=$(uptime)
    SHELL_INFO=$($SHELL --version | head -n 1)
    LOCAL_IP=$(ipswifi)
    PUBLIC_IP=$(ippub)
    USERS=$(whoami)

    # CPU
    if command -v lscpu &>/dev/null; then
        NUM_CPUS=$(lscpu | awk '/^CPU\(s\):/ {print $2}')
        CPU_MAX_MHZ=$(lscpu | awk '/^CPU max MHz:/ {print $4}')
        CPU_MHZ=$(lscpu | awk '/^CPU MHz:/ {print $3}')
        if [ -z "$CPU_MAX_MHZ" ]; then
            CPU_SPEED_MHZ="$CPU_MHZ"
        else
            CPU_SPEED_MHZ="$CPU_MAX_MHZ"
        fi
        CPU_SPEED_GHZ=$(awk -v freq="$CPU_SPEED_MHZ" 'BEGIN {printf "%.2f", freq/1000}')
        CPU="(${NUM_CPUS:-UNKNOWN}) @ ${CPU_SPEED_GHZ:-UNKNOWN}GHz"
    elif [ -f /proc/cpuinfo ]; then
        NUM_CPUS=$(grep -c ^processor /proc/cpuinfo)
        CPU_MHZ=$(grep "cpu MHz" /proc/cpuinfo | head -1 | awk '{print $4}')
        CPU_SPEED_GHZ=$(awk -v freq="$CPU_MHZ" 'BEGIN {printf "%.2f", freq/1000}')
        CPU="(${NUM_CPUS:-UNKNOWN}) @ ${CPU_SPEED_GHZ:-UNKNOWN}GHz"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        NUM_CPUS=$(sysctl -n hw.logicalcpu)
        CHIP_NAME=$(system_profiler SPHardwareDataType | awk -F": " '/Chip|Processor Name/ {print $2; exit}')
        if [[ "$CHIP_NAME" == "Apple M"* ]]; then
            # Apple Silicon
            TOTAL_CORES=$(system_profiler SPHardwareDataType | awk -F": " '/Total Number of Cores/ {print $2}')
            CPU="(${TOTAL_CORES:-UNKNOWN}) $CHIP_NAME"
        else
            # Intel
            CPU_SPEED_STR=$(system_profiler SPHardwareDataType | awk -F": " '/Processor Speed/ {print $2}')
            CPU_SPEED_GHZ=$(echo "$CPU_SPEED_STR" | sed 's/ GHz//')
            CPU="(${NUM_CPUS:-UNKNOWN}) $CHIP_NAME @ ${CPU_SPEED_GHZ:-UNKNOWN}GHz"
        fi
    fi

    # Memory
    if command -v free &>/dev/null; then
        MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
        MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
        MEMORY="${MEM_USED}MiB / ${MEM_TOTAL}MiB"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        MEM_USED=$(vm_stat | grep 'Pages active' | awk '{print $3}' | sed 's/\.//')
        MEM_INACTIVE=$(vm_stat | grep 'Pages inactive' | awk '{print $3}' | sed 's/\.//')
        MEM_FREE=$(vm_stat | grep 'Pages free' | awk '{print $3}' | sed 's/\.//')
        PAGE_SIZE=$(sysctl -n hw.pagesize)
        MEM_USED_MB=$(((MEM_USED + MEM_INACTIVE) * PAGE_SIZE / 1024 / 1024))
        MEM_TOTAL_MB=$(sysctl -n hw.memsize | awk '{print $1 / 1024 / 1024}')
        MEMORY="${MEM_USED_MB}MiB / ${MEM_TOTAL_MB%.*}MiB"
    fi

    # Battery
    if [[ "$OSTYPE" == "darwin"* ]]; then
        BATTERY=$(pmset -g batt | grep -Eo "\d+%.*;" | sed 's/;//')
    elif command -v acpi &>/dev/null; then
        BATTERY=$(acpi -b | awk -F', ' '{print $2 " " $3}')
    fi

    # Disk
    if command -v df &>/dev/null; then
        DISK=$(df -h $_disk_to_show | awk 'NR==2 {print $3 " used of " $2}')
    fi

    # Locale
    if command -v locale &>/dev/null; then
        LOCALE=$(locale | grep LANG= | cut -d= -f2)
    fi

    echo -e "${yellow}Shell:       ${endc} ${SHELL_INFO:-UNKNOWN}"
    echo -e "${yellow}CPU:         ${endc} ${CPU:-UNKNOWN}"
    echo -e "${yellow}Memory:      ${endc} ${MEMORY:-UNKNOWN}"
    echo -e "${yellow}Disk (df -H):${endc} ${DISK:-UNKNOWN} ($_disk_to_show)"
    echo -e "${yellow}Battery:     ${endc} ${BATTERY:-UNKNOWN}"
    echo -e "${yellow}Users:       ${endc} ${USERS:-UNKNOWN}"
    echo -e "${yellow}Uptime:      ${endc} ${UPTIME:-UNKNOWN}"
    echo -e "${yellow}Locale:      ${endc} ${LOCALE:-UNKNOWN}"
    echo -e "${yellow}Local IP:    ${endc} ${LOCAL_IP:-UNKNOWN}"
    echo -e "${yellow}Public IP:   ${endc} ${PUBLIC_IP:-UNKNOWN}"
    echo "${_OS:-UNKNOWN}"
}

_DESCRIPTIONS+=('print_welcome: Print welcome message')
print_welcome() {
    echo ""
    echo -e ${yellow}'$HOME:'${endc} "${HOME}"
    echo ""
    get_system_info
    echo $_welcome_message
    welcome_msg
}

if [[ $(isTermux) == 1 ]]; then
    # awk -v line="$line_number" '{if(NR==line) print "#" $0; else print $0}' "$file_name" > "${file_name}.tmp" && mv "${file_name}.tmp" "$file_name"

    _bashrc_file_path="$PREFIX/etc/bash.bashrc"
    _disk_to_show="/sdcard/"

    _motd="$PREFIX/etc/motd"
    [ -e $_motd ] && rm $_motd

    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8

    HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history.
    HISTSIZE=1000          # setting history length
    HISTFILESIZE=2000      # setting history length

    [[ "$UID" -eq 0 ]] && usercolor="${red}" || usercolor="${green}"

    [[ ${0##*/} == "bash" ]] && {
        shopt -s histappend # append to the history file, don't overwrite it
        shopt -s histverify
        PROMPT_DIRTRIM=2
        setps1
    }

    # sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://main.termux-mirror.ml stable mainn@' $PREFIX/etc/apt/sources.list # set faster repository

    # Termux also has an extra keys view which allows you to extend your current keyboard. To enable the extra keys view you have to long tap on the keyboard button in the left drawer menu.
    # Available extra-keys: CTRL ("special key, not repeat")  ALT ("special key, not repeat")  FN ("special key, not repeat")  ESC ("special key, not repeat")  TAB  HOME  END  PGUP  PGDN  INS  DEL  BKSP  UP  LEFT  RIGHT  DOWN  ENTER  BACKSLASH  QUOTE  APOSTROPHE
    rm $HOME/.termux/termux.properties
    _termux_extra_keys="$(
        cat <<-EOF
            shortcut.create-session=ctrl + t
            shortcut.next-session=ctrl + 2
            shortcut.previous-session=ctrl + 1
            shortcut.rename-session=ctrl + n
            enforce-char-based-input=true
            allow-external-apps=true
            extra-keys = [[ \
            {key:ESC,popup:{macro:'CTRL d',display:'Exit Session'}}, \
            {key:FN,popup:{macro:'CTRL t',display:'New Session'}}, \
            {key:F1,popup:F7}, \
            {key:F2,popup:F8}, \
            {key:F3,popup:F9}, \
            {key:F4,popup:F10}, \
            {key:UP,popup:PGUP}, \
            {key:F5,popup:F11}, \
            {key:F6,popup:F12} \
            ],[ \
            {key:TAB,popup:{macro:'CTRL n',display:'Name Session'}}, \
            {key:CTRL,popup:{macro:'CTRL 1',display:'Prev Session'}}, \
            {key:ALT, popup: {macro:'CTRL 2',display:'Next Session'}}, \
            {macro:'PASTE',display:'Paste',popup:{macro:'CTRL a',display:'Begin'}}, \
            {key:DEL,popup:INS}, \
            {key:LEFT,popup:HOME}, \
            {key:DOWN,popup:PGDN}, \
            {key:RIGHT,popup:END}, \
            {key:ENTER,popup:{macro:'CTRL c',display:'CNTRL+C'}} \
        ]]
EOF
    )"
    mkdir -p $PREFIX/etc/apt/sources.list.d
    mkdir -p $HOME/.termux/
    echo "${_termux_extra_keys}" >>$HOME/.termux/termux.properties
    termux-reload-settings

    alias open='termux-open'           #: open: display bash options settings
    alias trl='termux-reload-settings' #: trl: termux-reload-settings
    alias tss='termux-setup-storage'   #: tss: termux-setup-storage

    alias u='cd $PREFIX'              #: u: cd $PREFIX
    alias sdcard='cd /sdcard'         #: sdcard: 'cd /sdcard' in Termux Env
    alias docs='cd /sdcard/Documents' #: docs: 'cd /sdcard/Documents' in Termux Env
    alias downs='cd /sdcard/Download' #: downs: 'cd /sdcard/Download' in Termux Env

    if [ -x $PREFIX/libexec/termux/command-not-found ]; then
        command_not_found_handle() {
            $PREFIX/libexec/termux/command-not-found "$1" # Handle commands not found
        }
    fi

    _DESCRIPTIONS+=('backup: Backup Termux home and usr to sdcard/termux-backup.tar.gz')
    backup() {
        echom "Backupping Termux home and usr..." "*" "${yellow}"
        tar -zcvf /sdcard/termux-backup.tar.gz $HOME $PREFIX
        echom "Done" "*" "${green}"
    }

    _DESCRIPTIONS+=('restore: Restore Termux home and usr from sdcard/termux-backup.tar.gz')
    restore() {
        echom "Restoring Termux home and usr..." "*" "${yellow}"
        tar -zxf /sdcard/termux-backup.tar.gz --recursive-unlink --preserve-permissions --directory /data/data/com.termux/files
        echom "Done" "*" "${green}"
    }

    _DESCRIPTIONS+=('start_vscode: Start VSCode server in Termux background')
    start_vscode() {
        internal_run() { code-server --auth none --bind-addr 0.0.0.0:8080 --disable-telemetry; }
        [ -x $(command -v code-server) ] && {
            internal_run
        } || {
            npm -g install code-server
            internal_run
        }
    }

    _DESCRIPTIONS+=('wrap_vnc: -s = start / -c = configure / -x = stop VNC server in Termux background')
    wrap_vnc() {
        internal_start() {
            echom "Starting VNC Server..." "*" "${green}"
            export DISPLAY=":1"
            vncserver -localhost=0
        }
        internal_configure() {
            cat >$HOME/.vnc/xstartup <<-_EOF_
#!/data/data/com.termux/files/usr/bin/bash
# openbox-session &
xfce4-session &
_EOF_
        }
        internal_check_start() {
            if [[ $(pidof Xvnc) ]]; then
                echom "Server Already Running." "!" "${red}"
                vncserver -list
                echo "Kill VNC Server? (y/n) : "
                read VNC_REPLY
                [[ "$VNC_REPLY" =~ "y" ]] && {
                    killall Xvnc
                    echom "VNC killed." "*" "${green}"
                } || {
                    internal_start
                }
            fi
            internal_start
        }
        internal_stop() {
            vncserver -kill $DISPLAY
        }

        while getopts s:c:x o; do
            case $o in
            -s) internal_start ;;
            -c) internal_check_start ;;
            -x) internal_stop ;;
            *) internal_check_start ;;
            esac
        done
    }

    _DESCRIPTIONS+=('stx: Start native X session in Termux, if $1 is "nh" start nethunter X')
    stx() {
        # Kill open X11 processes
        kill -9 $(pgrep -f "termux.x11") 2>/dev/null

        # Enable PulseAudio over Network
        pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

        # Prepare termux-x11 session
        export XDG_RUNTIME_DIR=${TMPDIR}
        termux-x11 :0 >/dev/null &
        sleep 3 # Wait a bit until termux-x11 gets started.

        # Launch Termux X11 main activity
        am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity >/dev/null 2>&1
        sleep 1

        # Set audio server && Run XFCE4 Desktop
        if [[ "$1" == "nh" ]]; then
            nethunter -r 'export PULSE_SERVER=127.0.0.1 && export XDG_RUNTIME_DIR=${TMPDIR} && su - kali -c "env DISPLAY=:0 startxfce4"'
        else
            export PULSE_SERVER=127.0.0.1 && env DISPLAY=:0 dbus-launch --exit-with-session xfce4-session &
            >/dev/null 2>&1
        fi

        exit 0
    }

    _DESCRIPTIONS+=('set_desktop_env: Set desktop Termux env')
    set_desktop_env() {
        [[ ! -d "$HOME/Desktop" ]] && {
            mkdir $HOME/Desktop
            echom "Desktop folder created." "*" "${green}"
        }
        echo "Do you want to copy termux-desktop data in your home? (y/n) : "
        read CP_REPLY
        [[ "$CP_REPLY" =~ "y" ]] && {
            _termux_desktop_folder=$HOME/termux-desktop
            [[ ! -d "$_termux_desktop_folder" ]] && {
                git clone --depth=1 https://github.com/vivi7/termux-desktop.git $_termux_desktop_folder
                echom "termux-desktop cloned." "*" "${green}"
            }
            echom "Copying desktop data..." "*" "${yellow}"
            configs=($(ls -A $_termux_desktop_folder/files))
            for _config in "${configs[@]}"; do
                echom "Copying $_config..." "*" "${cyan}"
                cp -rf $_termux_desktop_folder/files/$_config $HOME
            done

            echo "Do you want to delete termux-desktop folder with all contents? (y/n) : "
            read RM_REPLY
            [[ "$RM_REPLY" =~ "y" ]] && { rm -rf $_termux_desktop_folder; }
        }
        echo "Do you want to have custom bookmarks for thunar? (y/n) : "
        read THUNAR_BOOKMARKS_REPLY
        [[ "$THUNAR_BOOKMARKS_REPLY" =~ "y" ]] && {
            cat >$HOME/.config/gtk-3.0/bookmarks <<EOF
file:///data/data/com.termux/files/home/storage/shared SDcard
file:///data/data/com.termux/files/usr User
file:///data/data/com.termux/files/home/storage/downloads Downloads
file:///data/data/com.termux/files/home/storage/pictures Pictures
file:///data/data/com.termux/files/home/storage/music Music
file:///data/data/com.termux/files/home/storage/dcim DCIM
file:///data/data/com.termux/files/home/storage/movies Movies
file:///data/data/com.termux/files/home/.local/share/Trash/files Trash

EOF
        }
        wrap_vnc configure
        echom "Desktop Environment set successfully" "*" "${green}"
    }

    _DESCRIPTIONS+=('install_must: Install must have Termux packages')
    install_must() {
        echom "Updating package repositories..." "*" "${yellow}"
        pkg update -y
        pkg upgrade -y
        pkg_repo=(
            x11-repo root-repo science-repo termux-api
        )
        pkg install -y "${pkg_repo[@]}"
        pkg update -y
        pkg_desktop=(
            termux-x11-nightly
            pulseaudio
            proot-distro
            xfce4 xfce4-goodies tur-repo
            virglrenderer-android wmctrl
        )
        pkg_programs=(
            chromium
            code-oss
        )
        pkg_proot=(
            proot tar axel
        )
        pkg_must=(
            termux-services ncurses-utils coreutils tsu
            htop-legacy openssl-tool openssh gnupg dbus
            tar git wget curl jq vim tree tmux dnsutils nmap
            zsh
            ffmpeg imagemagick
        )
        package_groups=(
            pkg_desktop
            pkg_programs
            pkg_proot
            pkg_must
        )
        for pkg_array_name in "${package_groups[@]}"; do
            echo "Do you want to install ${pkg_array_name}? (y/n) : "
            echo "${!pkg_array_name[@]}"
            read PKG_REPLY
            [[ "$PKG_REPLY" =~ "y" ]] && {
                echom "Installing packages from ${pkg_array_name}..." "*" "${yellow}"
                pkg install -y "${!pkg_array_name[@]}"
                for i in "${!pkg_array_name[@]}"; do
                    if [ -e $PREFIX/bin/$i ]; then
                        echom "  $i is OK" "*" "${green}"
                    else
                        printf "Installing ${i}...\n"
                        apt install -y $i || {
                            echom "ERROR: Failed to install package $i" "!" "${red}"
                        exit
                        }
                    fi
                done
            }
        done

        echom "All packages installed successfully" "*" "${green}"
        echom "You can also install: nodejs-lts, docker, golang, make, cmake, ndk-multilib, iproute2"
        config_git
        install_zsh
    }


    _DESCRIPTIONS+=('install_termux_desktop: Install desktop Termux packages')
    install_termux_desktop() {
        echo "Do you want to install termux-x11 deb and apk? (y/n) : "
        read TRX_REPLY
        [[ "$TRX_REPLY" =~ "y" ]] && {
            wget https://github.com/termux/termux-x11/releases/download/nightly/termux-x11-nightly-1.03.00-0-all.deb
            dpkg -i termux-x11-nightly-1.03.00-0-all.deb
            rm termux-x11-nightly-1.03.00-0-all.deb

            wget https://github.com/termux/termux-x11/releases/download/nightly/app-arm64-v8a-debug.apk
            mv app-arm64-v8a-debug.apk $HOME/storage/downloads/
            termux-open $HOME/storage/downloads/app-arm64-v8a-debug.apk
        }
        pkg_desktop=(
            termux-x11-nightly
            pulseaudio
            proot-distro
            xfce4 xfce4-goodies tur-repo
            virglrenderer-android wmctrl
        )
        echo "Related pkgs are:" "${pkgs[@]}"
        echo "Do you want termux-desktop? (install/uninstall) : "
        read INSTALL_REPLY
        if [[ "$INSTALL_REPLY" == "install" ]]; then
            pkg install -y "${pkgs[@]}"
            set_desktop_env
        elif [[ "$INSTALL_REPLY" == "uninstall" ]]; then
            apt-get remove -y --purge --autoremove $package "${pkgs[@]}"
            # TODO: remove desktop home data
            zip -r desktop_home.zip .config .local .mpd .ncmpcpp Music .fehbg .gitconfig .gtkrc-2.0 .vimrc .cache
            echo "Do you want to delete home/Desktop folder with all contents? (y/n) : "
            read RMF_REPLY
            [[ "$RMF_REPLY" =~ "y" ]] && { rm -rf $HOME/Desktop; }
            echom "Desktop Environment removed successfully" "*" "${green}"
        else
            echom "Arg must be: install/uninstall" "!" "${red}"
        fi
    }

    _DESCRIPTIONS+=('install_kali_nethunter_desktop: Install Kali NetHunter in Termux OS')
    install_kali_nethunter_desktop() {
        termux-setup-storage

        url="https://gitlab.com/kalilinux/nethunter/build-scripts/kali-nethunter-project/raw/master/nethunter-rootless/install-nethunter-termux"
        local_file="nh-termux-install.sh"

        online_version=$(curl -s "$url" | sed -n '3p')
        local_version=$(sed -n '3p' "./bin/$local_file")

        echo "Locale v: $local_version, Online v: $online_version"
        if [ "$online_version" != "$local_version" ]; then
            temp_file="install-nethunter-termux"
            curl -o ./bin/$temp_file $url
            awk '{gsub("-b /proc","-b /proc -b $HOME/storage/shared:/sdcard -b $PREFIX/tmp:/tmp -b $HOME/bashrc.sh:$home/bashrc.sh"); print}' ${temp_file} >${local_file}
            diff ${temp_file} ${local_file}
            rm ${temp_file}
        fi

        chmod +x ./bin/$local_file
        ./bin/$local_file

        echo -e "
nethunter                -> start Kali NetHunter command line interface
nethunter kex passwd     -> configure the KeX password (only needed before 1st use)
nethunter kex &          -> start Kali NetHunter Desktop Experience user sessions
nethunter kex stop       -> stop Kali NetHunter Desktop Experience
nethunter <command>      -> run in NetHunter environment
nethunter -r             -> start Kali NetHunter cli as root
nethunter -r kex passwd  -> configure the KeX password for root
nethunter -r kex &       -> start Kali NetHunter Desktop Experience as root
nethunter -r kex stop    -> stop Kali NetHunter Desktop Experience root sessions
nethunter -r kex kill    -> Kill all KeX sessions
nethunter -r <command>   -> run <command> in NetHunter environment as root
More instructions here:  -> https://www.kali.org/docs/nethunter/nethunter-rootless
"
    }

    _DESCRIPTIONS+=('welcome_msg: Display welcome message')
    welcome_msg() {
        echo ""
        echo -e " 
# Hardware Keyboard Shortcuts
# Ctrl + Alt + C → Create new session
# Ctrl + Alt + R → Rename current session
# Ctrl + Alt + Down arrow (or N) → Next session
# Ctrl + Alt + Up arrow (or P) → Previous session
# Ctrl + Alt + Right arrow → Open drawer
# Ctrl + Alt + Left arrow → Close drawer
# Ctrl + Alt + M → Show menu
# Ctrl + Alt + U → Select URL
# Ctrl + Alt + V → Paste
# Ctrl + Alt + +/- → Adjust text size
# Ctrl + Alt + 1-9 → Go to numbered session

# Update and install openssh and set password with:
pkg update && pkg install openssh && ssh-keygen -A && whoami && passwd
sshd
# To login using ssh client:
ssh $(whoami)@$(ipswifi) -p 8022

# To copy a file into termux:
scp -P 8022 bashrc.sh $(whoami)@$(ipswifi):/data/data/com.termux/files/home/
termux-setup-storage
scp -P 8022 <file_name> user@<ip>:/sdcard/Download/
"
    }
fi

if [[ $(isMac) == 1 ]]; then

    _bashrc_file_path=~/.bash_profile
    _disk_to_show='/'
    [ -x $(command -v airport) ] || { sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/sbin/airport; }

    alias kcamera='sudo killall VDCAssistant'                                                                                                                                                       #: kcamera: restart MacOS camera service
    alias ksophos='sudo killall SophosScanD SophosEventMonitor SophosServiceManager'                                                                                                                #: ksophos: kill sophos MacOS services
    alias hostr='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'                                                                                                                     #: hostr: source MacOS host file
    alias disable_gate_keeper='sudo spctl --master-disable'                                                                                                                                         #: disable_gate_keeper: disable MacOS gatekeaper
    alias f='open -a Finder ./'                                                                                                                                                                     #: f: Opens current directory in MacOS Finder
    alias force_empty='sudo rm -rf ~/.Trash/*'                                                                                                                                                      #: force_empty: force empty MacOS Finder trash
    alias mount_rw='/sbin/mount -uw /'                                                                                                                                                              #: mount_rw: For use when booted into MacOS single-user
    alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder" #: cleanupLS:  Clean up MacOS LaunchServices to remove duplicates in the "Open With" menu
    alias screensaver='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'                                               #: screensaver: Run a screensaver on the MacOS Desktop
    alias groupls='dscacheutil -q group -a name admin'                                                                                                                                              #: groupls: list of MacOS user groups
    alias edit_apache='sudo edit /etc/httpd/httpd.conf'                                                                                                                                             #: edit_apache: Edit MacOS httpd.conf
    alias restart_apache='sudo apachectl graceful'                                                                                                                                                  #: restart_apache: Restart MacOS Apache
    alias edit_hosts='sudo edit /etc/hosts'                                                                                                                                                         #: edit_hosts: Edit MacOS /etc/hosts file
    alias restart_hosts='sudo edit /etc/hosts'                                                                                                                                                      #: restart_hosts: Refresh MacOS hosts
    alias herr='tail /var/log/httpd/error_log'                                                                                                                                                      #: herr: Tails MacOS HTTP error logs
    alias logs_apache="less +F /var/log/apache2/error_log"                                                                                                                                          #: logs_apache: Shows MacOS apache error logs
    alias docs='cd ~/Documents'                                                                                                                                                                     #: docs: 'cd /sdcard/Documents' in MacOS Env
    alias downs='cd ~/Downloads'                                                                                                                                                                    #: downs: 'cd /sdcard/Downloads' in MacOS Env

    # Replace the declared one
    ipgatewifi() { netstat -nr | grep UGScg | awk '{print $2;}'; }
    ipparent() { netstat -nr | grep UGScg | awk '{print $4;}'; }
    _copy() { cat | pbcopy; }
    _paste() { pbpaste; }

    _DESCRIPTIONS+=('trash: Moves a file to the MacOS trash')
    trash() { mv "$@" ~/.Trash; }

    _DESCRIPTIONS+=('empty: Empty MacOS trash')
    empty() { sudo rm -rf ~/.Trash/*; }

    _DESCRIPTIONS+=('ql: Opens any file in MacOS Quicklook Preview')
    ql() { qlmanage -p "$*" >&/dev/null; }

    _DESCRIPTIONS+=('updateCask: Force update outdated MacOS cask apps')
    updateCask() { brew cask install --force $(brew cask outdated | cut -d" " -f1); }

    _DESCRIPTIONS+=('cleanBrewCasc: Cleaning Up cache brew and brew cask MacOS Files')
    cleanBrewCasc() {
        echom "Cleaning Up cache brew and brew cask Files" "*" "${yellow}"
        sudo rm -rf ~/Library/Caches/* #Homebrew/Cask
        sudo rm -rf /Library/Caches/*
        sudo rm -rf /System/Library/Caches/*
        brew cleanup
        echom "Cleaning Up cache brew and brew cask Files Completed" "*" "${green}"
    }

    _DESCRIPTIONS+=('kaudio: Restart MacOS audio')
    kaudio() { sudo kill -9 $(ps ax | grep 'coreaudio[a-z]' | awk '{print $1}'); }

    _DESCRIPTIONS+=('cdf: '\''Cd'\''s to frontmost window of MacOS Finder')
    cdf() {
        currFolderPath=$(
            /usr/bin/osascript <<EOT
                tell application "Finder"
                    try
                        set currFolder to (folder of the front window as alias)
                    on error
                        set currFolder to (path to desktop folder as alias)
                    end try
                    POSIX path of currFolder
                end tell
EOT
        )
        echo "cd to '$currFolderPath' "
        cd "$currFolderPath"
    }

    _DESCRIPTIONS+=('wrap_tor: Wrap all MacOS traffic by tor')
    wrap_tor() {
        action=$1 || '-w'
        shift
        case $action in
        -w) INTERFACE=Wi-Fi ;;
        -e) INTERFACE=Ethernet ;;
        -d) INTERFACE=Display Ethernet ;;
        *)
            echo "Error - Unrecognized action code '$action'"
            echo "    Usage:"
            echo "      -w - Wi-Fi"
            echo "      -e - Ethernet"
            echo "      -d - Display Ethernet"
            echo " " >&2
            exit 1
            ;;

            #s)  cp torx.sh /usr/local/bin/torx && chmod u+x ${0##*/} ;;
            #n) echo ${BASH_SOURCE[0]} ;;
        esac
        [[ -x $(command -v tor) ]] || { brew install tor; }
        sudo -v # Ask for the administrator password upfront

        # Keep-alive: update existing 'sudo' time stamp until finished
        while true; do
            sudo -n true
            sleep 60
            kill -0 "$$" || exit
        done 2>/dev/null &

        sudo networksetup -setsocksfirewallproxy $INTERFACE 127.0.0.1 9050 off
        sudo networksetup -setsocksfirewallproxystate $INTERFACE on
        tor
        sudo networksetup -setsocksfirewallproxystate $INTERFACE off
    }

    _DESCRIPTIONS+=('_should_load_brew_m1: Check MacOS arc and eval brew path if exist')
    _should_load_brew_m1() {
        [[ "$(uname -m)" == "arm64" && -f /opt/homebrew/bin/brew ]] && {
            eval "$(/opt/homebrew/bin/brew shellenv)"
            echo "Loaded brew for M1"
        }
    }
    _should_load_brew_m1 # eval per far funzionare brew su M1

    _DESCRIPTIONS+=('install_must: Install must have MacOS packages')
    install_must() {
        xcode-select --install
        [[ -x $(command -v brew) ]] || { /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }
        _should_load_brew_m1
        echom "Turn off brew analytics" "*" "${yellow}"
        brew analytics off
        echom "Installing brew formulas..." "*" "${yellow}"
        brew_formulas=(
            jq vim tree gnu-sed coreutils moreutils
            git-quick-stats
            ffmpeg imagemagick youtube-dl kalker
            findutils java android-platform-tools
            qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize suspicious-package apparency quicklookase qlvideo
            qlprettypatch quicklook-csv webpquicklook macdown qlswift
        )
        for brew_formula in "${brew_formulas[@]}"; do
            brew install $brew_formula
        done
        echom "Formulas installed successfully." "*" "${green}"
        echom "Installing brew Cask formulas..." "*" "${yellow}"
        brew_cask_formulas=(
            bettertouchtool maccy
            sourcetree visual-studio-code
            jdownloader the-unarchiver
            google-drive google-chrome
            virtualbox vlc mediainfo spotify
            telegram-desktop whatsapp zoom slack teamviewer
        )
        for brew_cask_formula in "${brew_cask_formulas[@]}"; do
            brew install --cask $brew_cask_formula
        done
        echom "Cask Formulas installed successfully." "*" "${green}"
        cleanBrewCasc
        config_git
        install_zsh
    }

    _DESCRIPTIONS+=('init_setup: Setup MacOS defaults')
    init_setup() {
        echom "General Settings" "-" "${cyan}"
        echo "Show all extensions"
        defaults write NSGlobalDomain AppleShowAllExtensions -bool true

        echo "Show library folder"
        chflags nohidden ~/Library

        echo "Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window"
        sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

        echo "Enable require password 5 seconds after sleep or screen saver begins"
        defaults write com.apple.screensaver askForPassword -int 1
        defaults write com.apple.screensaver askForPasswordDelay -int 5

        # echo "Save screenshots to custom location"
        # defaults write com.apple.screencapture location -string "${HOME}/ScreenShot/Desktop"
        echo "Save screenshots in PNG"
        defaults write com.apple.screencapture type -string "png"

        echo "Enable tap to click (Trackpad)"
        defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
        defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
        defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

        echo "Enable use scroll gesture with the Ctrl (^) modifier key to zoom"
        defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
        defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

        echo "Follow mouse when zoomed in"
        defaults write com.apple.universalaccess closeViewPanningMode -int 0

        echo "Enable full keyboard access for all controls (e.g. enable Tab in modal dialog-s)"
        defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

        echo "Tap with two fingers to emulate right click"
        defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

        # echo "Disable three finger drag"
        # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool false

        echo "Disable the 'Are you sure you want to open this application?' dialog"
        defaults write com.apple.LaunchServices LSQuarantine -bool false

        echo "Disable smart quotes and smart dashes"
        defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
        defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

        echo "Disable Photos.app from starting everytime a device is plugged in"
        defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

        echo "Disable changing file extension warning"
        defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

        echo "Disable creation of .DS_Store files on network volumes and everywhere"
        defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
        defaults write com.apple.desktopservices SDontWriteNetworkStores true

        echom "Finder" "-" "${cyan}"
        echo "Set the Default Finder View Style to Column"
        defaults write com.apple.Finder FXPreferredViewStyle Nlsv

        echo "Show hidden file and dotfiles"
        defaults write com.apple.Finder AppleShowAllFiles -bool true
        defaults write com.apple.finder AppleShowAllFiles TRUE

        echo "Display full POSIX path as Finder window title"
        defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

        echo "Hide icons for hard drives, servers, and removable media on the desktop"
        defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
        defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
        defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
        defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

        echo "Enable status bar"
        defaults write com.apple.finder ShowStatusBar -bool true

        echo "Enable text selection in quick look"
        defaults write com.apple.finder QLEnableTextSelection -bool true

        #Show icons for hard drives, servers, and removable media on the desktop
        #defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

        echo "Safari"
        echo "Enable Safari's debug, develop menu and web inspector"
        defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
        defaults write com.apple.Safari IncludeDevelopMenu -bool true
        defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
        defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
        #Adding a context menu item for showing the Web Inspector in web views
        defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
        echo "Disable Safari’s thumbnail cache for History and Top Sites"
        defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

        echo "Terminal"
        echo "Enable UTF-8 ONLY in Terminal.app and setting the Homebrew theme by default"
        defaults write com.apple.terminal StringEncodings -array 4
        defaults write com.apple.Terminal "Default Window Settings" -string "Homebrew"
        defaults write com.apple.Terminal "Startup Window Settings" -string "Homebrew"

        echo "Mac App Store"
        echo "Enable the WebKit Developer Tools in the Mac App Store"
        defaults write com.apple.appstore WebKitDeveloperExtras -bool true
        echo "Enable Debug Menu in the Mac App Store"
        defaults write com.apple.appstore ShowDebugMenu -bool true

        echo "Disk Utility"
        echo "Enable the debug menu in Disk Utility"
        defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
        defaults write com.apple.DiskUtility advanced-image-options -bool true

        echo "Disable disk image verification"
        defaults write com.apple.frameworks.diskimages skip-verify -bool true
        defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
        defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

        echo "Activity Monitor"
        echo "Show the main window when launching Activity Monitor"
        defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
        echo "Visualize CPU usage in the Activity Monitor Dock icon"
        defaults write com.apple.ActivityMonitor IconType -int 5
        echo "Show all processes in Activity Monitor"
        defaults write com.apple.ActivityMonitor ShowCategory -int 0
        echo "Sort Activity Monitor results by CPU usage"
        defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
        defaults write com.apple.ActivityMonitor SortDirection -int 0

        echo "Dock"
        echo "Enable autohide dock with no delay"
        defaults write com.apple.dock autohide -boolean true
        defaults write com.apple.dock autohide -bool true
        defaults write com.apple.dock autohide-delay -float 0
        defaults write com.apple.dock autohide-time-modifier -float 0

        echo "Disable automatic rearrangement of spaces based on most recent usage"
        defaults write com.apple.dock mru-spaces -bool false

        defaults write com.apple.finder ShowAllFiles TRUE
        defaults write com.apple.desktopservices SDontWriteNetworkStores true
        defaults write com.apple.finder QLEnableTextSelection -bool TRUE
        killall Finder

        config_git
    }
    welcome_msg() {
        echo -e " "
    }
fi

if [[ $(isSynology) == 1 ]]; then

    docker_volume_prefix="/volume1"
    docker_volume_config_prefix="$docker_volume_prefix/docker"

    _DESCRIPTIONS+=('check_docker: Check Synology docker permission instance')
    check_docker() {
        if [[ ! $(cat /etc/group | grep docker) =~ $USER ]]; then
            echo -e "
            Creating docker group, adding $USER into it and changing docker.sock owner
            If you get again issue please run follow command:
                sudo chown root:administrators /var/run/docker.sock"
            sudo synogroup --add docker
            sudo synogroup --member docker $USER
            sudo chown root:docker /var/run/docker.sock
        fi
    }

    _DESCRIPTIONS+=('_fix_macvlan_vmm_vswitch: Remove and recreate MacVLAN after Synology vSwitch changes')
    _fix_macvlan_vmm_vswitch() {
        docker network rm VLAN_NAS
        dockermacvlan
        docker ps -f "status=exited" | awk '!/NAMES/ {print $NF;}' | xargs -I@ bash -c "xargs docker network connect VLAN_NAS @ && docker start @"
    }

    _DESCRIPTIONS+=('enable_usb_supporter: Enable USB support for Synology devices')
    enable_usb_supporter() {
        /sbin/modprobe usbserial
        /sbin/modprobe ftdi_sio
        /sbin/modprobe cdc-acm
        chmod 777 /dev/ttyUSB0
        chmod 777 /dev/ttyACM0
        echo -e "
        Install community package: 
            SynoCli Kernel Tools
            SynoKernel USB Serial drivers

        They will support:
            CC2531 Dongle Zigbee Supported on DSM 7.
            CC2652RB Supported on DSM 7.
            Wireless USB ASUS NANO N10 Supported on DSM 7.
            ConBee II Zigbee Supported on DSM 7.
            Z-Wave Stick Supported on DSM 7.
            3D Printers Supported on DSM 7.
        "
    }

    _DESCRIPTIONS+=('welcome_msg: Display welcome message')
    welcome_msg() {
        echo -e " "
    }

fi

if [[ $(isKali) == 1 ]]; then
    _DESCRIPTIONS+=('_fix_bluetooth: fix bluethoot enabling for Kali OS')
    _fix_bluetooth() {
        rfkill unblock bluetooth
        systemctl enable bluetooth.service
        systemctl start bluetooth.service
        sudo systemctl restart bluetooth.service
    }

    _DESCRIPTIONS+=('_fix_printer: fix printer adding for Kali OS')
    _fix_printer() {
        sudo service cups start
        sudo apt install cups cups-client cups-filters cups-ipp-utils
    }

    _DESCRIPTIONS+=('_fix_docker: fix docker adding user to docker group for Kali OS')
    _fix_docker() {
        sudo usermod -aG docker $USER
    }

fi

if [[ $(isParrot) == 1 ]]; then
    _DESCRIPTIONS+=('install_must: Install must have Parrot OS packages')
    install_must() {
        sudo apt update

        apt_packages=(
            jq vim tree gnu-sed coreutils moreutils
            git-quick-stats
            ffmpeg imagemagick youtube-dl
            findutils java android-platform-tools
            xclip caffeine
            gparted snapd nautilus-admin gnome-tweaks
            code
            google-chrome-stable chrome-gnome-shell
        )
        for apt_package in "${apt_packages[@]}"; do
            apt install -y $apt_package
        done
        echom "Apts installed successfully." "*" "${green}"
        echom "flatpak install flathub org.kde.haruna" "*" "${green}"
        echom "flatpak run org.kde.haruna" "*" "${green}"

        config_git
        install_zsh
    }

    _DESCRIPTIONS+=('install_chrome: Install google chrome')
    install_chrome() {
        # wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        # sudo dpkg -I google-chrome-stable_current_amd64.deb && rm google-chrome-stable_current_amd64.deb
        wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google_linux_signing_key.gpg
        sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google_linux_signing_key.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'
        sudo apt update && sudo apt install -y google-chrome-stable chrome-gnome-shell
    }

fi

if [[ $(isPop) == 1 ]]; then
    _DESCRIPTIONS+=('install_anonsurf: Install anonsurf')
    install_anonsurf() {
        git clone https://github.com/Und3rf10w/kali-anonsurf.git && cd kali-anonsurf
        sudo ./installer.sh && cd ..
    }

    _DESCRIPTIONS+=('popupdate: Update all Pop OS')
    popupdate() {
        sudo apt update
        sudo apt upgrade
        sudo apt dist-upgrade
        sudo apt autoremove
        sudo apt autoclean
        sudo fwupdmgr get-devices
        sudo fwupdmgr get-updates
        sudo fwupdmgr update
        flatpak update
        sudo pop-upgrade recovery upgrade from-release # this updates the recovery partition
        echo "Do you want to reboot? (y/n) : "
        read REBOOT_REPLY
        [[ "$REBOOT_REPLY" =~ "y" ]] && {
            sudo reboot now
        }
    }

fi

_vimrc="$(
    cat <<\EOF
set nocompatible    " Set compatibility to Vim only.
set ruler    "Always show current position
syntax on    " Turn on syntax highlighting.
set modelines=0    " Turn off modelines
set ignorecase    " Ignore case when searching
set smartcase     " When searching try to be smart about cases
set lazyredraw    " Don't redraw while executing macros (good performance config)
set magic    " For regular expressions turn magic on
set scrolloff=5    " Display 5 lines above/below the cursor when scrolling with a mouse.
set backspace=indent,eol,start    " Fixes common backspace problems
set matchpairs+=<:>    " Highlight matching pairs of brackets. Use the '%' character to jump between them.
set number    " Show line numbers
highlight LineNr ctermfg=white    " Color line numbers
set encoding=utf-8    " Encoding
set hlsearch    " Highlight matching search patterns
set incsearch    " Enable incremental search
set viminfo='100,<9999,s100'    " Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set showmode
set showcmd
set cmdheight=1

set textwidth=80      " Set the max textwidth. Use a value corresponding to the width of your screen.
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

set laststatus=2    " Set status line display 
hi StatusLine ctermfg=NONE ctermbg=red cterm=NONE
hi StatusLineNC ctermfg=black ctermbg=red cterm=NONE
hi User1 ctermfg=black ctermbg=magenta
hi User2 ctermfg=NONE ctermbg=NONE
hi User3 ctermfg=black ctermbg=blue
hi User4 ctermfg=black ctermbg=cyan
set statusline=\                    " Padding
set statusline+=%f                  " Path to the file
set statusline+=\ %1*\              " Padding & switch colour
set statusline+=%y                  " File type
set statusline+=\ %2*\              " Padding & switch colour
set statusline+=%=                  " Switch to right-side
set statusline+=\ %3*\              " Padding & switch colour
set statusline+=line                " of Text
set statusline+=\                   " Padding
set statusline+=%l                  " Current line
set statusline+=\ %4*\              " Padding & switch colour
set statusline+=of                  " of Text
set statusline+=\                   " Padding
set statusline+=%L                  " Total line
set statusline+=\                   " Padding 

EOF
)"

_git_config="$(
    cat <<\EOF
[github]
  user = UNAME
  token = TOKEN
[user]
  email = email@gmail.com
  name = NAME
  username = UNAME
[core]
  autocrlf = input
  editor = vim
  whitespace = fix,-indent-with-non-tab,trailing-space,cr-at-eol
  excludesfile = ~/.gitignore
[alias]
  alias = !git config --global -l | grep ^alias
  alignstaging = !git checkout staging && git merge develop && git push && git checkout develop
  amend = commit -n --amend --no-edit
  assume = update-index --assume-unchanged
  assumed = !git ls-files -v | grep ^h | cut -c 3-
  br = branch
  changes = diff --name-status -r
  ci = commit
  co = checkout
  cum = commit
  dc = diff --cached
  df = diff
  doctor = !git fsck && git gc --prune=now && git fsck
  fixup = commit -n --amend --no-edit
  frune = fetch --prune
  ignore = "!gi() { curl -L -s https://www.gitignore.io/api/$@ ;}; gi"
  last = log -1 HEAD
  files = printf %"s\\n" `git show --pretty="" --name-only HEAD`
  lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
  publish = !git push -u origin $( git rev-parse --abbrev-ref HEAD )
  puff = pull --ff
  #roulette = !sh -c '[ $[ $RANDOM % 6 ] == 0 ] && git push origin :master || echo *click*'
  release = !sh -c 'git tag v$1 && git push --tags' -
  unrelease = !sh -c 'git tag -d v$1 && git push origin :v$1' -
  save = !git add -A && git commit -nm "SAVEPOINT"
  snap = !git stash save 'snapshot: $(date)' && git stash apply 'stash@{0}'
  st = !sh -c 'echo "$(git show -s --format=%s)" && git status -sb' -
  staging = rebase --autostash staging
  stat = diff --stat -r
  unassume = update-index --no-assume-unchanged
  undo = reset HEAD^ --mixed
  unpublish = !git push origin :$( git rev-parse --abbrev-ref HEAD ) && git branch --unset-upstream
  unstage = reset HEAD --
  untrack = rm -r --cache --
  wip = !git add -u && git commit -nm "WIP"
  wipe = !git add -A && git commit -nqm "WIPE SAVEPOINT" && git reset HEAD~1 --hard
  squash = !sh -c 'git rebase --interactive HEAD~$1' -
  removelocalbrinorigin = !sh -c "git branch -vv | grep 'origin/.*]' | awk '{print $1}' | xargs git branch -d"
  removelocalbrnotinorigin = !sh -c "git branch -vv | grep 'origin/.*]' -v | awk '{print $1}' | xargs git branch -d"
  cob = checkout -b
  cor = !sh -c 'git checkout $1 && git submodule update --recursive' -
  who = for-each-ref --format='%(committerdate) %(refname) %(authorname)'
  brull = !sh -c 'git fetch origin $1:$1'
  brsls = git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
  bra = !sh -c 'git branch -a | xargs printf %"s\\n"'
  clbra = !sh -c """for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master `; do git branch --track ${branch#remotes/origin/} $branch; done"""
[merge]
  ff = true
[push]
  default = simple
[color]
  ui = always
[color "branch"]
  current = yellow bold
  local = green bold
  remote = cyan bold
[color "diff"]
  meta = yellow bold
  frag = magenta bold
  old = red bold
  new = green bold
  whitespace = red reverse
[color "status"]
  added = green bold
  changed = yellow bold
  untracked = red bold
[difftool "sourcetree"]
  cmd = opendiff \"$LOCAL\" \"$REMOTE\"
  path =
[mergetool "sourcetree"]
  cmd = /Applications/SourceTree.app/Contents/Resources/opendiff-w.sh \"$LOCAL\" \"$REMOTE\" -ancestor \"$BASE\" -merge \"$MERGED\"
  trustExitCode = true
[commit]

[credential]
  helper = osxkeychain

EOF
)"

_new_script="$(
    cat <<\EOF
#!/bin/sh
PROGNAME=$0
usage() {
  echo $'\e[1;31m' "\nUsage: $PROGNAME [-v] [-d <dir>] [-f <file>] \n
-f <file>: Specify file path
 -d <dir>: Specify directory path
       -v: verbose" "\n" $'\e[0m' #end red color
  exit 1
}
dir=default_dir file=default_file verbose_level=0
while getopts 'd:f:v' o; do       # put : after if require an argumnt
  case $o in
    (f) file=$OPTARG;;
    (d) dir=$OPTARG;;
    (v) verbose_level=$((verbose_level + 1));;
    (*) usage
  esac
done
shift "$((OPTIND - 1))"
echo Remaining arguments: "$@"

EOF
)"

_zshrc="$(
    cat <<\EOF
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="spaceship"
SPACESHIP_TIME_SHOW="true"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
ZSH_DISABLE_COMPFIX="true"
plugins=(
  git  npm  macos  torrent
  zsh-syntax-highlighting  zsh-autosuggestions  zsh-completions
)
source $ZSH/oh-my-zsh.sh
function zsh_options() {
    PLUGIN_PATH="$ZSH/plugins/"
    for plugin in $plugins; do
        echo "\n\nPlugin: $plugin"; 
        grep -r "^function \w*" $PLUGIN_PATH$plugin | \
            awk '{print $2}' | \
            sed "s/()//" | \ 
            tr '\n' ', '; 
        grep -r "^alias" $PLUGIN_PATH$plugin | awk '{print $2}' | sed 's/=.*//' |  tr '\n' ', ' ;
    done
}

EOF
)"

load_envs
addpath ./bin -s
print_welcome

#   diskutil eject /dev/disk1s3  #  remove_disk: spin down unneeded disk
#   hdiutil chpass /path/to/the/diskimage  #   to change the password on an encrypted disk image
#   hdiutil attach example.dmg -shadow /tmp/example.shadow -noverify  #   to mount a read-only disk image as read-write

#   mounting a removable drive (of type msdos or hfs)
#   ---------------------------------------
#   mkdir /Volumes/Foo
#   ls /dev/disk*   to find out the device to use in the mount command)
#   mount -t msdos /dev/disk1s1 /Volumes/Foo
#   mount -t hfs /dev/disk1s1 /Volumes/Foo

#   to create a file of a given size: /usr/sbin/mkfile or /usr/bin/hdiutil
#   ---------------------------------------
#   e.g.: mkfile 10m 10MB.dat
#   e.g.: hdiutil create -size 10m 10MB.dmg
#   the above create files that are almost all zeros - if random bytes are desired
#   then use: ~/Dev/Perl/randBytes 1048576 > 10MB.dat
#
# Go http://huawei_routher_address/html/dhcp.html and press F12 and in console put:
# $('#input_dhcp_subnet_mask').show();
# $('#dhcp_dns_statistic').show();
# $('#dhcp_primary_dns').show();
# $('#dhcp_secondary_dns').show();
# or create a bookmark with this url:
# javascript:$('#input_dhcp_subnet_mask').show();$('#dhcp_dns_statistic').show();$('#dhcp_primary_dns').show();$('#dhcp_secondary_dns').show();

# No GUI on launch, fresh install
# sudo mount -o remount,rw /dev/YOUR_PARTITION /
# and than upgrade will fix
