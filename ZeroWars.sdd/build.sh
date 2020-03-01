name="zerowars.sdd"
dir="/home/pt/.steam/steam/steamapps/common/Zero-K/maps/"
path=$dir$name

if [[ "$1" == "merge" ]]; then

    if [ -d "$path" -a ! -h "$path" ]; then
        cp -Rf * $path
    else
        mkdir $path
        cp -r * $path
    fi

elif [[ "$1" == "replace" ]]; then
    rm -rf $path
    mkdir $path
    cp -r * $path

elif [[ "$1" == "zip" ]]; then
    rm -rf $path.sd7
    7z a -ms=off $path.sd7 *

elif [[ "$1" == "clean" ]]; then
    rm -rf $path
    rm -rf $path.sd7
fi

