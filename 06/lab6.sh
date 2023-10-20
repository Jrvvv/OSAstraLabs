#!/bin/bash

# • useradd – создание учетной записи пользователя
# • usermod – изменение параметров учетной записи пользователя
# • userdel – удаление учетной записи пользователя
# • groupadd – создание учетной записи группы
# • groupmod – изменение параметров учетной записи группы
# • groupdel – удаление учетной записи группы.

# Part 1
# С помощью команд useradd, groupadd, passwd создайте учетную запись user1 со следующими параметрами:
# • UID - 1500;
# • основная (первичная) группа user1 (GID 1500);
# • дополнительная группа - video;
# • домашний каталог должен быть создан;
# • входной командный интерпретатор - /bin/bash;
# • задать пароль по своему усмотрению;
# • время действия пароля - 60 дней;
# • пользователь должен сменить пароль при первом входе в систему.
sudo groupadd -g 1500 user1
sudo groupadd video

sudo useradd -m user1 -u 1500 -s /bin/bash -g user1

# вторичная группа
sudo usermod -aG video user1

# установка и ограничение действия пароля, смена при первом входе
sudo passwd user1
sudo chage -M 60 user1
sudo chage -d 0 user1

# Part 2
# Проверяем, верно ли создан пользователь
sudo su user1
sudo chage -l user1
sudo id user1

# Part 3
# С помощью команд adduser, addgroup, создайте учетную запись user2 со следующими параметрами:
# UID - 2000;
# основная группа user2 (GID 2000);
# дополнительная группа users;
# GECOS: полное имя- Пользователь 2, номер комнаты - 111, рабочий телефон 111-111, остальные поля пустые;
sudo addgroup --gid 2000 user2
sudo adduser --uid 2000 --gid 2000 user2
# Вводим данные, предлставленные выше
sudo adduser user2 users
sudo id user2

# Part 4
# Проверьте, что учетная запись создана согласно требованиям из предыдущего пункта (используйте команду lslogins)
# и зайдите в систему под учетной записью user2.
lslogins | grep user2
sudo su user2

# Part 5
# Преобразуем обои, создаем новый /usr/share/images/spacefun.png файл, устанавливаем в качестве фона рабочего стола
sudo bash -c "svg-convert /usr/share/images/desktop-base/spacefun-wallpaper-widescreen.svg > /usr/share/images/spacefun.png"
# Меняем путь до обоев
# sudo sed -i 's/^WallPaper=.*/WallPaper=\/usr\/share\/images\/spacefun.png' /usr/share/desktop-base/grub_background.sh
sudo sed -i 's/^WallPaper=.*/WallPaper=\/usr\/share\/images\/spacefun.png' /usr/share/fly-wm/theme/default.themerc
sudo sed -i 's/WallPaperPos =.*/WallPaperPos = Stretch/' /usr/share/fly-wm/theme/default.themerc

# Part 6
# С помощью графической утилиты (fly-admin-smc) создайте учетную запись user3 со следующими параметрами:
# • UID - 2500:
# • основная группа user3 (GID 2500);
# • дополнительные группы: users, cdrom;
# • задайте пароль по своему усмотрению;
# • время действия пароля - 30 дней;
# • минимальное время между сменой пароля - 14 дней;
# • время неактивности пользователя после окончания действия пароля – 60 дней.

sudo fly-admin-smc
# -> Пользователи -> Добавить -> Задаем параметры
# -> Пользователи -> User3 -> Срок действия -> Задаем параметры

# Part 7
# Проверьте, что параметры учетной записи user3 соответствуют заданию.
sudo chage -l user3
sudo id user3
# Зайдите этим пользователем в графическое окружение и убедитесь, что обои - новые.
# Вход от лица user3

# Part 8
# Настройте PAM так, чтобы запоминалось 5 последних паролей пользователей, не давая их использовать при очередной смене пароля
# Проверьте, что нельзя использовать предыдущие пароли.
sudo nano /etc/pam.d/password
# or /etc/pam.d/common-password
# add lines
# "password required pam_unix.so      remember=5"
# "password required pam_pwhistory.so remember=5"

# Part 9
# Когда passwd запускается от имени пользователя root, то можно задавать «плохие» пароли, несмотря на предупреждение команды passwd. 
# Настройте PAM так, чтобы и пользователь root не мог задавать пароли из словаря.
# Проверьте, что пользователь root должен придерживаться тех же правил формирования пароля, что и обычные пользователи.
sudo apt-get update
sudo apt-get install libpam-cracklib
sudo apt-get install --reinstall libpam-pwquality

sudo nano /etc/pam.d/password
# add line
# password               required                        pam_cracklib.so       enforce_for_root

# Part 10
# Задайте любое значение переменной окружения VAR в файле /etc/environment.
sudo bash -c "echo \"VAR=AAAOOOAAA\" >> /etc/environment"
. ~/.bashrc

# Part 11
# Проверьте, что при входе в систему переменная VAR определена.
sudo echo "$VAR"

# Part 12
# Заблокируйте учетную запись user3.
sudo passwd -l user3
sudo passwd -S user3
# второе поле L или LK


