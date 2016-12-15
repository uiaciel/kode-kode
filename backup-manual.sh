#!/bin/bash
# Move Backup Public_html dan Database Harian
# First Source : https://nicaw.wordpress.com/2013/04/18/bash-backup-rotation-script/
# Bash Script untuk backup harian, mingguan dan bulanan
# Bash Script for backup Manually Cpanel Account daily and move to Weekly, Monthly Folder
# Please Check again, Thanks you

# Step 1
BACKUP_DIR=/home/backup
FILES_DIR=/home/USER/public_html

# Dump MySQL Database
mysqldump -pPASSWORD -uUSER DATABASENAME > $BACKUP_DIR/incoming/`date +%Y_%m_%d`.sql

# Rsync folder public_html
rsync -az /home/USER/public_html/ $BACKUP_DIR/incoming/`date +%Y_%m_%d`

# Step 2
cd $BACKUP_DIR

# Folder Saat backup Awal
source=$BACKUP_DIR/incoming

# Nama Folder berdasarkan tanggal
date_daily=`date +"%d-%m-%Y"`

# Penamaan untuk Mingguan dan bulanan

mingguan=`date +"%d-%m-%Y" -d "1 week ago"`
bulanan=`date +"%d-%m-%Y" -d "1 month ago"`

# Jika Nama Folder Backup sama dengan tanggal bulanan/mingguan/harian, pindahkan ke Folder masing-masing
# Menjadikan Destination

# Bulanan
if [ "$bulanan" = "$date_daily" ] ; then
  destination=/home/backup/bulanan/
else
  # Mingguan
  if [ "$mingguan" = "$date_daily" ] ; then
    destination=/home/backup/mingguan/
  else
    # Jika Bukan Bulanan atau Mingguan, pindah ke harian
    destination=/home/backup/harian/
  fi
fi

# Step 3
# Pindahkan File atau Folder

mkdir $destination
mv -v $source/* $destination

# Hapus Data yang 6 hari lalu 
rm -rf /home/backup/harian/`date +"%d-%m-%Y" -d "6 day ago"`

# Hapus Data 5 Minggu lalu
rm -rf /home/backup/mingguan/`date +"%d-%m-%Y" -d "5 week ago"`

# Hapus Data 4 Bulan Lalu
rm -rf /home/backup/mingguan/`date +"%d-%m-%Y" -d "4 month ago"`
