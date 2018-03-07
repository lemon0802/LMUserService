#!/bin/bash

git stash
git pull origin master --tags
git stash pop

VersionString=`grep -E 's.version.*=' LMUserServeice.podspec`
VersionNumber="${VersionString##*=}"
#VersionNumber=`tr -cd 0-9 <<<"$VersionString"`

#NewVersionNumber=$(($VersionNumber + 1))
#LineNumber=`grep -nE 's.version.*=' LMUserServeice.podspec | cut -d : -f1`
#sed -i "" "${LineNumber}s/${VersionNumber}/${NewVersionNumber}/g" LMUserServeice.podspec

confirmed="n"
NewVersionNumber=""
echo "当前版本号：${VersionString}"
getNewVersionNumber() {
read -p "输入新版本号: " NewVersionNumber

    if test -z "$NewVersionNumber"; then
        getNewVersionNumber
    fi
}

echo -e "\n"
while [ "$confirmed" != "y" -a "$confirmed" != "Y" ]
do
    if [ "$confirmed" == "n" -o "$confirmed" == "N" ]; then
        getNewVersionNumber
    fi
    read -p "输入版本为${NewVersionNumber}，检查是否正确? (y/n):" confirmed
done

#NewVersionNumber="\"${NewVersionNumber}\""

LineNumber=`grep -nE 's.version.*=' LMUserServeice.podspec | cut -d : -f1`
sed -i "" "${LineNumber}s/${VersionNumber}/\"${NewVersionNumber}\"/g" LMUserServeice.podspec

echo "current version is ${VersionString}, new version is \"${NewVersionNumber}\""

git add .
git commit -am ${NewVersionNumber}
git tag ${NewVersionNumber}
git push origin master --tags
cd ~/.cocoapods/repos/LMBHPrivatePod && git pull origin master && cd - && pod repo push LMBHPrivatePod LMUserServeice.podspec --verbose --allow-warnings --use-libraries

