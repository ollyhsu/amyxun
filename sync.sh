#!/bin/bash

html=$(curl https://www.amyxun.com)

axmath_fname=$(echo $html |grep -Eo '公式编辑器_AxMath_Setup_Win_[0-9]*.zip' | sort | uniq)
axmath_versions_remote=$(echo $axmath_fname | sed -e 's;公式编辑器_AxMath_Setup_Win_\([0-9]*\).zip;\1;g')
axmath_url=$( echo $html | grep -Eo "https?://[a-zA-Z0-9\.\/_&=@$%?~#-]*AxMath[a-zA-Z0-9\.\/_&=@$%?~#-]*")

axglyph_fname=$(echo $html |grep -Eo '矢量绘图_AxGlyph_Setup_Win_[0-9]*.zip'  | sort | uniq)
axglyph_versions_remote=$(echo $axglyph_fname | sed -e 's;矢量绘图_AxGlyph_Setup_Win_\([0-9]*\).zip;\1;g')
axglyph_url=$(echo $html | grep -Eo "https?://[a-zA-Z0-9\.\/_&=@$%?~#-]*AxGlyph[a-zA-Z0-9\.\/_&=@$%?~#-]*")

axmath_versions_local=$(cat axmath.txt | grep -Eo '公式编辑器_AxMath_Setup_Win_[0-9]*.zip' | sort | uniq | sed -e 's;公式编辑器_AxMath_Setup_Win_\([0-9]*\).zip;\1;g')
axglyph_versions_local=$(cat axglyph.txt | grep -Eo '矢量绘图_AxGlyph_Setup_Win_[0-9]*.zip' | sort | uniq | sed -e 's;矢量绘图_AxGlyph_Setup_Win_\([0-9]*\).zip;\1;g')

# echo $axmath_versions_local:$axmath_versions_remote
# echo $axglyph_versions_local:$axglyph_versions_remote



if (( $axmath_versions_local == $axmath_versions_remote  ))
then
    echo "AxMath 无需更新~"
else
    echo "AxMath 正在更新..."
    rm -rf AxMath/*
    wget -O AxMath/$axmath_fname $axmath_url
    sha256sum AxMath/$axmath_fname > AxMath/$axmath_fname.sha256sum
    echo $axmath_fname > axmath.txt
    echo "AxMath 更新完成~"
fi

if (( $axglyph_versions_local == $axglyph_versions_remote  ))
then
    echo "AxGlyph 无需更新~"
else
    echo "AxGlyph 正在更新..."
    rm -rf AxGlyph/*
    wget -O AxGlyph/$axglyph_fname $axglyph_url
    sha256sum AxGlyph/$axglyph_fname > AxGlyph/$axglyph_fname.sha256sum
    echo $axglyph_fname > axglyph.txt
    echo "AxGlyph 更新完成~"
fi

echo "AxMath & AxGlyph 同步完成~"
