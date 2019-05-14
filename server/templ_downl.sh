# !/bin/bash

# rm -rf ./templates/*
# rm -rf ./static/*
# Качаем страницу переданную в параметре $1 по адресу ./path/скачанные файлы
# Интересующие нас файлы будут в ./path/bash.im/
wget -E -H -k -K -p $1 -P ./path

# Уачаем html файл страницу
# Если передоваемый адресс имеет вид https://bash.im/page_name
# Перед эти удаляем https:/ из параметра, получаем ./path/bash.im/page_name.html
# И перемещаем в ./templates/template.html
echo ${1#???????}
mv -f ./path${1#???????}.html ./templates/template.html

# Переносим оставшиеся папки из ./path/bash.im/ в ./static
mv -f ./path/bash.im/*/ ./static

# Преобразуем в html файле ascii код в '?'
sed -i '' 's/%3F/?/' ./templates/template.html

# Преобразуем ссылки на статические файлы для flask
IFS=$'\n' array=( $(find ./static -type f | cut -c 10- | sed 's/\//\\&/g') )
for rec in ${array[@]}; do 
    sed -i '' 's/'"$rec"'/{{url_for('"'"'static'"'"', filename = '"'"'&'"'"')}}/' ./templates/template.html
done
sed -i '' 's/..\/{{url_for('"'"'static/{{url_for('"'"'static/' ./templates/template.html

# Деламе из ссылок на bash.im относительные ссылки
sed -i '' 's/https:\/\/bash.im//' ./templates/template.html

# # Удаляем лишние файлы
rm -rf ./path