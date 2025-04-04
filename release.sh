
###
 # @Author: Vincent Yang
 # @Date: 2025-04-04 17:41:22
 # @LastEditors: Vincent Yang
 # @LastEditTime: 2025-04-04 17:41:56
 # @FilePath: /bob-plugin-raycast/release.sh
 # @Telegram: https://t.me/missuo
 # @GitHub: https://github.com/missuo
 # 
 # Copyright © 2025 by Vincent, All Rights Reserved. 
### 
version=${1#refs/tags/v}
zip -r -j bob-plugin-raycast-$version.bobplugin src/*

sha256_raycast=$(sha256sum bob-plugin-raycast-$version.bobplugin | cut -d ' ' -f 1)
echo $sha256_raycast

download_link="https://github.com/missuo/bob-plugin-raycast/releases/download/v$version/bob-plugin-raycast-$version.bobplugin"

new_version="{\"version\": \"$version\", \"desc\": \"None\", \"sha256\": \"$sha256_raycast\", \"url\": \"$download_link\", \"minBobVersion\": \"1.8.0\"}"

json_file='appcast.json'
json_data=$(cat $json_file)

updated_json=$(echo $json_data | jq --argjson new_version "$new_version" '.versions = [$new_version] + .versions')

echo $updated_json > $json_file
mkdir dist
mv *.bobplugin dist