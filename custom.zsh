# =========================
# 1. General Aliases
# =========================
alias se="sequelize"
alias hi="echo Say hello"
alias open="explorer.exe"
alias op="nvim $ZSH_CUSTOM/custom.zsh"
alias ncc="\"/mnt/c/Program Files/Notepad++/notepad++.exe\""
alias n='nvim'
alias apply="source $HOME/.zshrc"
alias set='n ~/.zshrc'
alias cls='clear'
alias ch='~/myst/change-blade.zsh'
alias set-nvim='n ~/.config/nvim/init.vim'
alias set-vim='n ~/.vimrc'
alias ff='n $(rg --files| fzf)'
alias fo='fzf | xargs -r nvim'
alias xx='chmod +x'
alias xxa="chmod +x $(pwd)/*"
alias path='echo $PATH | tr '\'':'\'' '\''\n'\'' | sort'

# =========================
# 2. Git Aliases
# =========================
alias gdev='git checkout develop'
alias gprev='git checkout -'
alias glast='git checkout $(git for-each-ref --sort=-committerdate refs/heads/ --format="%(refname:short)" | head -n1)'

# =========================
# 3. Windows/WSL Integration
# =========================
alias ps='/mnt/c/Users/myPC/AppData/Local/Microsoft/WindowsApps/pwsh.exe -Command'
alias a='/mnt/c/Users/myPC/AppData/Local/Microsoft/WindowsApps/pwsh.exe -Command php artisan'

# =========================
# 4. PHP & Laravel Aliases
# =========================
alias a='php artisan'
alias change-php='sudo update-alternatives --config php'

# =========================
# 5. MySQL/MariaDB Aliases
# =========================
alias m-start="sudo service mysql start"
alias m-stop="sudo service mysql stop"
alias m-status="sudo service mysql status"
# alias in="mysql -u test_user -ppassword"

# =========================
# 6. Database Helper Aliases
# =========================
alias show='show_tables'
alias in='access'
alias desc='desc_table'
alias see='see_table'

# =========================
# 7. File Management Functions
# =========================
li() {
    local path="."
    local sort_order="none"

    # Xử lý đối số
    for arg in "$@"; do
        case "$arg" in
            -a|--ascending)  sort_order="asc" ;;
            -d|--descending) sort_order="desc" ;;
            /*|.|~*)          path="$arg" ;;
            *)               [[ -d "$arg" ]] && path="$arg" ;;
        esac
    done

    # Đảm bảo lệnh cần thiết có
    command -v /usr/bin/find >/dev/null || { echo "find not found"; return 1; }
    command -v /usr/bin/stat >/dev/null || { echo "stat not found"; return 1; }
    command -v /usr/bin/du >/dev/null || { echo "du not found"; return 1; }

    format_size() {
        local bytes=$1
        local units=("B" "KB" "MB" "GB" "TB")
        local i=0
        while (( bytes >= 1024 && i < ${#units[@]} - 1 )); do
            bytes=$((bytes / 1024))
            ((i++))
        done
        echo "${bytes} ${units[$i]}"
    }

    local entries=()

    while IFS= read -r -d '' item; do
        local name size icon hidden_mark

        name=$(/usr/bin/basename "$item")
        [[ "$name" == .* ]] && hidden_mark="🔒" || hidden_mark=""

        if [[ -d "$item" ]]; then
            icon="📁"
            size=$(/usr/bin/du -sb "$item" 2>/dev/null | /usr/bin/cut -f1)
            name="$name/"
        else
            icon="📄"
            size=$(/usr/bin/stat -c%s "$item" 2>/dev/null)
        fi

        entries+=("$size|$icon $name|$(format_size "$size")|$hidden_mark")
    done < <(/usr/bin/find "$path" -mindepth 1 -maxdepth 1 -print0)

    if [[ "$sort_order" == "desc" ]]; then
        sorted=($(printf "%s\n" "${entries[@]}" | /usr/bin/sort -t'|' -k1 -nr))
    elif [[ "$sort_order" == "asc" ]]; then
        sorted=($(printf "%s\n" "${entries[@]}" | /usr/bin/sort -t'|' -k1 -n))
    else
        sorted=("${entries[@]}")
    fi

    for line in "${sorted[@]}"; do
        IFS='|' read -r _size name size_human mark <<< "$line"
        printf "%-48s %10s %s\n" "$name" "$size_human" "$mark"
    done
}

# Copy custom.zsh to $HOME/bin
cp -f "$ZSH_CUSTOM/custom.zsh" $HOME/bin

# =========================
# 8. Database Functions
# =========================

# Show all databases
show-tables() {
    mysql -u test_user -ppassword -e "SHOW DATABASES;"
}

# Load .env variables
load_env_vars() {
    if [[ ! -f .env ]]; then
        echo "Error: .env file not found in $(pwd)"
        return 1
    fi

    DB_USERNAME=""
    DB_PASSWORD=""
    DB_DATABASE=""

    while IFS='=' read -r key value; do
        [[ -z "$key" || "$key" =~ ^# ]] && continue
        key=$(echo "$key" | xargs)
        value=$(echo "$value" | xargs)
        case "$key" in
            "DB_USERNAME") DB_USERNAME="$value" ;;
            "DB_PASSWORD") DB_PASSWORD="$value" ;;
            "DB_DATABASE") DB_DATABASE="$value" ;;
        esac
    done < .env

    if [[ -z "$DB_USERNAME" ]]; then
        echo "Error: DB_USERNAME not found in .env"
        return 1
    fi
    if [[ -z "$DB_PASSWORD" ]]; then
        echo "Error: DB_PASSWORD not found in .env"
        return 1
    fi
    if [[ -z "$DB_DATABASE" ]]; then
        echo "Error: DB_DATABASE not found in .env"
        return 1
    fi

    export DB_USERNAME DB_PASSWORD DB_DATABASE
}

# Access MySQL with .env credentials
access() {
    if [[ -z "$DB_USERNAME" || -z "$DB_PASSWORD" || -z "$DB_DATABASE" ]]; then
        load_env_vars || return 1
    fi
    mysql -u "$DB_USERNAME" -p"$DB_PASSWORD" "$@"
}

# Show tables in current database
show_tables() {
    access -e "USE $DB_DATABASE; ${1:-SHOW TABLES;}"
}

# Describe a table
desc_table() {
    if [[ -z "$1" ]]; then
        echo "Error: Table name required"
        return 1
    fi
    access -e "USE $DB_DATABASE; DESCRIBE $1;"
}

# See all rows in a table
see_table() {
    if [[ -z "$1" ]]; then
        echo "Error: Table name required"
        return 1
    fi

    local table_param="$1"
    local result=$(access -e "USE $DB_DATABASE; SELECT * FROM $table_param \G;" 2>/dev/null)

    if [[ -z "$result" ]]; then
        echo "Empty result"
    else
        echo "$result"
    fi
}

# =========================
# 9. Laravel Helper Functions
# =========================
run-seed(){
    a db:seed DatabaseSeeder
    a db:seed NoteSeeder
    a db:seed ShareNoteSeeder
}

# =========================
# 10. Git Helper Functions
# =========================
gnewb(){
    echo -n "Type new branch: "
    read branch
    git checkout -b $branch
}

# =========================
# 11. SSH Functions
# =========================
ssh-s2() {
    echo "Attempting to connect to 100.90.233.9..."
    if ssh chuminh@100.90.233.9; then
        echo "Connection successful."
    else
        echo "First connection failed. Attempting to connect to chuminh-x99.tail49bc5a.ts.net..."
        ssh chuminh@chuminh-x99.tail49bc5a.ts.net
    fi
}

# =========================
# 12. MongoDB Aliases
# =========================
alias mongosh='mongosh "mongodb://localhost:27017/note_app" --eval'
