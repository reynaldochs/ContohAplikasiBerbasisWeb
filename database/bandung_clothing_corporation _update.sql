/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 10.4.17-MariaDB : Database - bandung_clothing_corporation
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bandung_clothing_corporation` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `bandung_clothing_corporation`;

/*Table structure for table `akun` */

DROP TABLE IF EXISTS `akun`;

CREATE TABLE `akun` (
  `kode_akun` char(10) NOT NULL,
  `nama_akun` varchar(255) NOT NULL,
  `header_akun` char(10) NOT NULL,
  PRIMARY KEY (`kode_akun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `akun` */

insert  into `akun`(`kode_akun`,`nama_akun`,`header_akun`) values 
('1','Aktiva',''),
('11','Aktiva Lancar','1'),
('111','Kas','11'),
('112','Piutang','11'),
('113','Persediaan Bahan Baku',''),
('114','Pembelian Bahan Baku',''),
('2','Utang',''),
('211','Utang Usaha','2'),
('3','Modal',''),
('311','Modal','3'),
('312','Prive','3'),
('4','Pendapatan',''),
('411','Penjualan','4'),
('412','Penjualan Online','4'),
('5','Beban',''),
('511','Beban Listrik dan Air','5'),
('512','Beban Gaji dan Upah','5'),
('513','Beban Sewa Kantor','5'),
('514','Beban Iklan','5'),
('515','Beban Administrasi Lain-Lain','5'),
('516','Harga Pokok Penjualan','5'),
('517','Beban Transportasi Penjualan Online','5'),
('518','Beban Alat Tulis Kantor','5');

/*Table structure for table `bahan_baku` */

DROP TABLE IF EXISTS `bahan_baku`;

CREATE TABLE `bahan_baku` (
  `id` char(10) NOT NULL,
  `nama_bahan_baku` varchar(200) NOT NULL,
  `satuan` varchar(200) NOT NULL,
  `harga_satuan` double NOT NULL,
  `stok` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `bahan_baku` */

insert  into `bahan_baku`(`id`,`nama_bahan_baku`,`satuan`,`harga_satuan`,`stok`) values 
('BB001','Cotton Combed Black','Meter',35000,0),
('BB002','Benang Hitam','Roll',5000,0),
('BB003','Kain Katun','Meter',35000,0),
('BB004','Kancing Kemeja','Lusin',10000,0),
('BB005','Coil Zipper Ykk','Pcs',7000,0),
('BB006','Cotton Combed White','Meter',35000,0);

/*Table structure for table `barang` */

DROP TABLE IF EXISTS `barang`;

CREATE TABLE `barang` (
  `id` char(10) NOT NULL,
  `kategori_barang_id` char(10) NOT NULL,
  `nama_barang` varchar(200) NOT NULL,
  `harga_jual_satuan` double NOT NULL,
  `harga_produk_satuan` double NOT NULL,
  `stok` int(11) NOT NULL,
  `gambar` varchar(255) NOT NULL,
  `is_popular` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `barang_kategori_barang_id_foreign` (`kategori_barang_id`),
  CONSTRAINT `barang_kategori_barang_id_foreign` FOREIGN KEY (`kategori_barang_id`) REFERENCES `kategori_barang` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `barang` */

insert  into `barang`(`id`,`kategori_barang_id`,`nama_barang`,`harga_jual_satuan`,`harga_produk_satuan`,`stok`,`gambar`,`is_popular`) values 
('BR001','KB001','Vneck T-shirt Black',80000,30000,78,'',1),
('BR002','KB002','Cotton Black Shirt',75000,50000,82,'608bed68ad141.jpg',1),
('BR003','KB002','Long Sleve Black Shirt',150000,100000,118,'608bed3fe96cb.jpg',1),
('BR004','KB003','Zipper White Hoodie',250000,200000,98,'608bed2e38997.jpg',1),
('BR005','KB003','Hoodie Black',230000,150000,98,'608bed02b3339.jpg',1),
('BR006','KB003','Jaket Zipper Black',225000,185000,79,'608bec2376997.jpg',1),
('BR007','KB003','Red Hodie',130000,0,108,'60cdf5995eace.jpg',1),
('BR008','KB002','Cotton White Shirt',80000,0,0,'default.jpg',1),
('BR009','KB003','xyz',300000,0,0,'default.jpg',3);

/*Table structure for table `bom` */

DROP TABLE IF EXISTS `bom`;

CREATE TABLE `bom` (
  `id` char(10) NOT NULL,
  `barang_id` char(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bom_barang_id_foreign` (`barang_id`),
  CONSTRAINT `bom_barang_id_foreign` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `bom` */

insert  into `bom`(`id`,`barang_id`) values 
('BM002','BR001'),
('BM001','BR002'),
('BM003','BR003'),
('BM005','BR004'),
('BM004','BR005'),
('BM006','BR006'),
('BM007','BR007'),
('BM008','BR008'),
('BM009','BR009');

/*Table structure for table `cart` */

DROP TABLE IF EXISTS `cart`;

CREATE TABLE `cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pelanggan_id` varchar(30) NOT NULL,
  `barang_id` varchar(30) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;

/*Data for the table `cart` */

insert  into `cart`(`id`,`pelanggan_id`,`barang_id`,`jumlah`,`status`) values 
(1,'PL012','BR005',1,3),
(2,'PL013','BR006',1,3),
(5,'PL006','BR002',2,3),
(6,'PL006','BR005',3,3),
(7,'PL008','BR005',1,3),
(8,'PL008','BR004',1,3),
(9,'PL006','BR004',1,3),
(10,'PL006','BR006',3,3),
(11,'PL006','BR007',1,3),
(12,'PL006','BR006',3,3),
(13,'PL006','BR005',3,3),
(15,'PL006','BR003',1,2),
(16,'PL006','BR005',1,2);

/*Table structure for table `detail_bom` */

DROP TABLE IF EXISTS `detail_bom`;

CREATE TABLE `detail_bom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bom_id` char(10) NOT NULL,
  `bahan_baku_id` char(10) NOT NULL,
  `komposisi` float(11,1) NOT NULL,
  `satuan` varchar(255) NOT NULL,
  `keterangan` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `detail_bom_bahan_baku_id_foreign` (`bahan_baku_id`),
  KEY `detail_bom_bom_id_foreign` (`bom_id`),
  CONSTRAINT `detail_bom_bahan_baku_id_foreign` FOREIGN KEY (`bahan_baku_id`) REFERENCES `bahan_baku` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_bom_bom_id_foreign` FOREIGN KEY (`bom_id`) REFERENCES `bom` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4;

/*Data for the table `detail_bom` */

insert  into `detail_bom`(`id`,`bom_id`,`bahan_baku_id`,`komposisi`,`satuan`,`keterangan`) values 
(94,'BM001','BB004',1.0,'Lusin','Bahan Penolong'),
(95,'BM001','BB003',1.0,'Meter','Bahan Baku'),
(96,'BM002','BB001',1.5,'meter','Bahan Baku'),
(97,'BM002','BB002',1.0,'roll','Bahan Penolong'),
(98,'BM003','BB001',1.8,'meter','Bahan Baku'),
(99,'BM003','BB002',0.5,'roll','Bahan Penolong'),
(103,'BM004','BB005',1.0,'Pcs','Bahan Penolong'),
(104,'BM004','BB001',1.8,'Meter','Bahan Baku'),
(105,'BM004','BB002',0.5,'Roll','Bahan Penolong'),
(106,'BM005','BB005',1.0,'Pcs','Bahan Penolong'),
(107,'BM005','BB001',1.8,'Meter','Bahan Baku'),
(108,'BM005','BB002',0.5,'Roll','Bahan Penolong'),
(109,'BM006','BB005',1.0,'Pcs','Bahan Penolong'),
(110,'BM006','BB001',2.3,'Meter',''),
(111,'BM006','BB002',1.0,'Roll','Bahan Penolong'),
(112,'BM007','BB005',1.2,'Pcs','Bahan Penolong'),
(113,'BM007','BB001',2.0,'Meter','Bahan Baku'),
(114,'BM008','BB006',1.0,'Meter','Bahan Baku'),
(115,'BM008','BB002',1.0,'Roll','Bahan Penolong'),
(119,'BM009','BB004',10.0,'Pcs','Bahan Baku');

/*Table structure for table `detail_pembelian` */

DROP TABLE IF EXISTS `detail_pembelian`;

CREATE TABLE `detail_pembelian` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pembelian_id` char(20) NOT NULL,
  `bahan_baku_id` char(10) NOT NULL,
  `harga_satuan` double NOT NULL,
  `jumlah_pembelian` int(11) NOT NULL,
  `sub_total` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `detail_pembelian_bahan_baku_id_foreign` (`bahan_baku_id`),
  KEY `detail_pembelian_pembelian_id_foreign` (`pembelian_id`),
  CONSTRAINT `detail_pembelian_bahan_baku_id_foreign` FOREIGN KEY (`bahan_baku_id`) REFERENCES `bahan_baku` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_pembelian_pembelian_id_foreign` FOREIGN KEY (`pembelian_id`) REFERENCES `pembelian` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4;

/*Data for the table `detail_pembelian` */

insert  into `detail_pembelian`(`id`,`pembelian_id`,`bahan_baku_id`,`harga_satuan`,`jumlah_pembelian`,`sub_total`) values 
(53,'PM01052100001','BB001',35000,45,1575000),
(54,'PM01052100001','BB002',5000,30,150000),
(55,'PM01052100001','BB003',35000,20,700000),
(56,'PM01052100001','BB004',10000,20,200000),
(57,'PM21052100002','BB001',35000,5,157500),
(58,'PM21052100002','BB002',5000,3,15000),
(59,'PM05062100003','BB001',35000,150,5250000),
(60,'PM05062100003','BB002',5000,100,500000),
(61,'PM05062100004','BB001',35000,45,1575000),
(62,'PM05062100004','BB002',5000,30,150000),
(63,'PM05062100005','BB001',35000,45,1575000),
(64,'PM05062100005','BB002',5000,30,150000),
(65,'PM05062100006','BB001',35000,75,2625000),
(66,'PM05062100006','BB002',5000,50,250000),
(67,'PM18062100007','BB001',35000,3,105000),
(68,'PM18062100007','BB002',5000,2,10000),
(69,'PM18062100008','BB001',35000,36,1260000),
(70,'PM18062100008','BB002',5000,10,50000),
(71,'PM18062100009','BB001',35000,36,1260000),
(72,'PM18062100009','BB002',5000,10,50000),
(73,'PM19062100010','BB001',35000,986,34517000),
(74,'PM19062100010','BB002',5000,250,1247500),
(75,'PM19062100010','BB005',7000,430,3008600),
(76,'PM28062100011','BB002',5000,100,500000),
(77,'PM28062100011','BB006',35000,100,3500000),
(78,'PM08092100012','BB003',35000,5,175000),
(79,'PM08092100012','BB004',10000,5,50000),
(80,'PM08092100013','BB003',35000,2,70000),
(81,'PM08092100013','BB004',10000,2,20000),
(82,'PM08092100014','BB004',10000,1000,10000000),
(83,'PM08092100015','BB004',10000,10000,100000000),
(84,'PM15092100016','BB001',35000,150,5250000),
(85,'PM15092100016','BB002',5000,100,500000),
(86,'PM16092100017','BB001',35000,180,6300000),
(87,'PM16092100017','BB002',5000,50,250000),
(88,'PM16092100017','BB005',7000,100,700000);

/*Table structure for table `detail_penerimaan` */

DROP TABLE IF EXISTS `detail_penerimaan`;

CREATE TABLE `detail_penerimaan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_penerimaan` varchar(30) NOT NULL,
  `id_barang` varchar(30) NOT NULL,
  `ukuran` enum('AllSize','XS','S','FitS','M','FitM','L','FitL','XL','FitXL','XXL','FitXXL') DEFAULT NULL,
  `biaya_bahan_baku` double NOT NULL,
  `biaya_produksi` double NOT NULL,
  `biaya_tambahan` double NOT NULL,
  `qty` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;

/*Data for the table `detail_penerimaan` */

insert  into `detail_penerimaan`(`id`,`id_penerimaan`,`id_barang`,`ukuran`,`biaya_bahan_baku`,`biaya_produksi`,`biaya_tambahan`,`qty`) values 
(30,'PNR05062100001','BR001',NULL,1725000,500000,100000,30),
(31,'PNR05062100001','BR002',NULL,900000,450000,75000,20),
(33,'PNR05062100002','BR001',NULL,172500,50000,10000,3),
(34,'PNR05062100003','BR001',NULL,5750000,1500000,1000000,100),
(36,'PNR05062100004','BR001',NULL,1725000,600000,12000,30),
(37,'PNR18062100005','BR003',NULL,1309999.966621399,400000,150000,20),
(38,'PNR19062100006','BR003',NULL,6549999.833106995,300000,150000,100),
(39,'PNR19062100006','BR004',NULL,7249999.833106995,300000,150000,100),
(40,'PNR19062100006','BR005',NULL,7177499.834775925,300000,150000,99),
(41,'PNR19062100006','BR006',NULL,9249999.833106995,300000,150000,100),
(42,'PNR19062100006','BR007',NULL,8545600.036382675,350000,155000,109),
(43,'PNR28062100007','BR008',NULL,4000000,750000,100000,100),
(44,'PNR28062100008','BR001',NULL,115000,60000,10000,2),
(45,'PNR07092100009','BR002',NULL,225000,50000,0,5),
(46,'PNR08092100010','BR002',NULL,90000,50000,0,2),
(47,'PNR08092100011','BR009',NULL,10000000,1000000,0,100),
(48,'PNR08092100012','BR009',NULL,100000000,500000,0,1000),
(49,'PNR16092100013','BR001',NULL,5750000,1000000,500000,100),
(50,'PNR16092100014','BR004','AllSize',7249999.833106995,1000000,500000,100);

/*Table structure for table `detail_pengadaan` */

DROP TABLE IF EXISTS `detail_pengadaan`;

CREATE TABLE `detail_pengadaan` (
  `id_transaksi` varchar(30) NOT NULL,
  `id_barang` varchar(20) NOT NULL,
  `ukuran` enum('AllSize','XS','S','FitS','M','FitM','L','FitL','XL','XXL','FitXL','FitXXL') DEFAULT NULL,
  `qty` int(11) NOT NULL,
  `subtotal` int(11) NOT NULL,
  `harga_satuan` int(11) NOT NULL,
  PRIMARY KEY (`id_transaksi`,`id_barang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `detail_pengadaan` */

insert  into `detail_pengadaan`(`id_transaksi`,`id_barang`,`ukuran`,`qty`,`subtotal`,`harga_satuan`) values 
('PG-01052100001','BR001',NULL,30,0,0),
('PG-01052100001','BR002',NULL,20,0,0),
('PG-05062100003','BR001',NULL,100,0,0),
('PG-05062100004','BR001',NULL,30,0,0),
('PG-05062100005','BR001',NULL,30,0,0),
('PG-05062100006','BR001',NULL,50,0,0),
('PG-07092100011','BR002',NULL,5,0,0),
('PG-08092100012','BR002',NULL,2,0,0),
('PG-08092100013','BR009',NULL,100,0,0),
('PG-08092100014','BR009',NULL,1000,0,0),
('PG-14092100015','BR001','M',100,0,0),
('PG-16092100016','BR004','AllSize',100,0,0),
('PG-18062100007','BR001',NULL,2,0,0),
('PG-18062100008','BR003',NULL,20,0,0),
('PG-19062100009','BR003',NULL,100,0,0),
('PG-19062100009','BR004',NULL,100,0,0),
('PG-19062100009','BR005',NULL,99,0,0),
('PG-19062100009','BR006',NULL,100,0,0),
('PG-19062100009','BR007',NULL,109,0,0),
('PG-21052100002','BR001',NULL,3,0,0),
('PG-28062100010','BR008',NULL,100,0,0);

/*Table structure for table `detail_penjualan` */

DROP TABLE IF EXISTS `detail_penjualan`;

CREATE TABLE `detail_penjualan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `penjualan_id` char(20) NOT NULL,
  `barang_id` char(10) NOT NULL,
  `ukuran` enum('AllSize','XS','S','FitS','M','FitM','L','FitL','XL','FitXL','XXL','FitXXL') DEFAULT NULL,
  `harga_satuan` double NOT NULL,
  `jumlah_penjualan` int(11) NOT NULL,
  `sub_total` double NOT NULL,
  `keterangan` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `detail_penjualan_penjualan_id` (`penjualan_id`),
  KEY `detail_penjualan_barang_id_foreign` (`barang_id`),
  CONSTRAINT `detail_penjualan_barang_id_foreign` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_penjualan_penjualan_id` FOREIGN KEY (`penjualan_id`) REFERENCES `penjualan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

/*Data for the table `detail_penjualan` */

insert  into `detail_penjualan`(`id`,`penjualan_id`,`barang_id`,`ukuran`,`harga_satuan`,`jumlah_penjualan`,`sub_total`,`keterangan`) values 
(6,'PNJF-26122000004','BR006',NULL,225000,20,4500000,''),
(7,'PNJF-26122000004','BR003',NULL,150000,15,2250000,''),
(8,'PNJF-28122000005','BR003',NULL,150000,10,750000,''),
(9,'PNJF-28122000006','BR001',NULL,50000,10,500000,''),
(10,'PNJF-28122000006','BR002',NULL,75000,3,225000,''),
(11,'PNJF-18062100007','BR001',NULL,80000,3,240000,''),
(12,'PNJF-18062100007','BR002',NULL,75000,2,150000,''),
(13,'PNJF-19062100008','BR005',NULL,230000,2,460000,''),
(14,'PNJF-19062100008','BR004',NULL,250000,1,250000,''),
(15,'PNJF-19062100009','BR006',NULL,225000,1,225000,''),
(16,'PNJF-19062100010','BR007',NULL,130000,1,130000,''),
(17,'PNJF-21062100011','BR003',NULL,150000,1,150000,''),
(18,'PNJF-21062100012','BR003',NULL,150000,1,150000,''),
(19,'PNJF-21062100013','BR004',NULL,250000,1,250000,'');

/*Table structure for table `jurnal` */

DROP TABLE IF EXISTS `jurnal`;

CREATE TABLE `jurnal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kode_akun` varchar(10) NOT NULL,
  `id_transaksi` varchar(20) NOT NULL,
  `tgl_transaksi` date DEFAULT NULL,
  `posisi_dr_cr` varchar(6) DEFAULT NULL,
  `nominal` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=latin1;

/*Data for the table `jurnal` */

insert  into `jurnal`(`id`,`kode_akun`,`id_transaksi`,`tgl_transaksi`,`posisi_dr_cr`,`nominal`) values 
(1,'111','MD-26122000002','2020-12-26','debet',1000000),
(2,'311','MD-26122000002','2020-12-26','kredit',1000000),
(3,'111','PNJF-26122000004','2020-12-26','debet',6750000),
(4,'411','PNJF-26122000004','2020-12-26','kredit',6750000),
(5,'516','PNJF-26122000004','2020-12-26','debet',3700000),
(6,'113','PNJF-26122000004','2020-12-26','kredit',3700000),
(7,'511','PYMNT-26122000002','2020-12-26','debet',150000),
(8,'111','PYMNT-26122000002','2020-12-26','kredit',150000),
(9,'111','MD-28122000003','2020-12-28','debet',500000),
(10,'311','MD-28122000003','2020-12-28','kredit',500000),
(11,'111','PNJF-28122000005','2020-12-28','debet',750000),
(12,'411','PNJF-28122000005','2020-12-28','kredit',750000),
(13,'516','PNJF-28122000005','2020-12-28','debet',1000000),
(14,'113','PNJF-28122000005','2020-12-28','kredit',1000000),
(15,'111','MD-04062100004','2021-06-04','debet',600000),
(16,'311','MD-04062100004','2021-06-04','kredit',600000),
(17,'512','PYMNT-04062100003','2021-06-04','debet',100000),
(18,'111','PYMNT-04062100003','2021-06-04','kredit',100000),
(19,'111','PNJOL-17062100003','2021-06-17','debet',250000),
(20,'412','PNJOL-17062100003','2021-06-17','kredit',250000),
(21,'516','PNJOL-17062100003','2021-06-17','debet',77000),
(22,'113','PNJOL-17062100003','2021-06-17','kredit',77000),
(23,'114','PM18062100009','2021-06-18','debet',1310000),
(24,'111','PM18062100009','2021-06-18','kredit',1310000),
(25,'111','PNJF-18062100007','2021-06-18','debet',390000),
(26,'411','PNJF-18062100007','2021-06-18','kredit',390000),
(27,'516','PNJF-18062100007','2021-06-18','debet',375000),
(28,'113','PNJF-18062100007','2021-06-18','kredit',375000),
(29,'111','PNJF-28122000006','2021-06-18','debet',725000),
(30,'411','PNJF-28122000006','2021-06-18','kredit',NULL),
(31,'516','PNJF-28122000006','2021-06-18','debet',0),
(32,'113','PNJF-28122000006','2021-06-18','kredit',988750),
(33,'111','MD-19062100005','2021-06-19','debet',100000),
(34,'311','MD-19062100005','2021-06-19','kredit',100000),
(35,'312','MD-19062100006','2021-06-19','debet',50000),
(36,'111','MD-19062100006','2021-06-19','kredit',50000),
(37,'114','PM19062100010','2021-06-19','debet',38773100),
(38,'111','PM19062100010','2021-06-19','kredit',38773100),
(39,'111','PNJF-19062100008','2021-06-19','debet',710000),
(40,'411','PNJF-19062100008','2021-06-19','kredit',710000),
(41,'516','PNJF-19062100008','2021-06-19','debet',231090),
(42,'113','PNJF-19062100008','2021-06-19','kredit',231090),
(43,'111','PNJF-19062100009','2021-06-19','debet',225000),
(44,'411','PNJF-19062100009','2021-06-19','kredit',225000),
(45,'516','PNJF-19062100009','2021-06-19','debet',97000),
(46,'113','PNJF-19062100009','2021-06-19','kredit',97000),
(47,'111','PNJF-19062100010','2021-06-19','debet',130000),
(48,'411','PNJF-19062100010','2021-06-19','kredit',130000),
(49,'516','PNJF-19062100010','2021-06-19','debet',83033),
(50,'113','PNJF-19062100010','2021-06-19','kredit',83033),
(51,'512','PYMNT-19062100004','2021-06-19','debet',90000),
(52,'111','PYMNT-19062100004','2021-06-19','kredit',90000),
(53,'512','PYMNT-19062100005','2021-06-19','debet',20000),
(54,'111','PYMNT-19062100005','2021-06-19','kredit',20000),
(55,'518','PYMNT-20062100006','2021-06-20','debet',20000),
(56,'111','PYMNT-20062100006','2021-06-20','kredit',20000),
(57,'518','PYMNT-20062100007','2021-06-20','debet',10000),
(58,'111','PYMNT-20062100007','2021-06-20','kredit',10000),
(59,'111','PNJF-21062100011','2021-06-21','debet',150000),
(60,'411','PNJF-21062100011','2021-06-21','kredit',150000),
(61,'516','PNJF-21062100011','2021-06-21','debet',93000),
(62,'113','PNJF-21062100011','2021-06-21','kredit',93000),
(63,'111','PNJF-21062100012','2021-06-21','debet',150000),
(64,'411','PNJF-21062100012','2021-06-21','kredit',150000),
(65,'516','PNJF-21062100012','2021-06-21','debet',93000),
(66,'113','PNJF-21062100012','2021-06-21','kredit',93000),
(67,'111','PNJF-21062100013','2021-06-21','debet',250000),
(68,'411','PNJF-21062100013','2021-06-21','kredit',250000),
(69,'516','PNJF-21062100013','2021-06-21','debet',77000),
(70,'113','PNJF-21062100013','2021-06-21','kredit',77000),
(71,'111','PNJOL-19062100004','2021-06-27','debet',230000),
(72,'517','PNJOL-19062100004','2021-06-27','debet',20000),
(73,'412','PNJOL-19062100004','2021-06-27','kredit',250000),
(74,'516','PNJOL-19062100004','2021-06-27','debet',77045),
(75,'113','PNJOL-19062100004','2021-06-27','kredit',77045),
(76,'111','PNJOL-27062100006','2021-06-28','debet',605000),
(77,'517','PNJOL-27062100006','2021-06-28','debet',16000),
(78,'412','PNJOL-27062100006','2021-06-28','kredit',621000),
(79,'516','PNJOL-27062100006','2021-06-28','debet',257033),
(80,'113','PNJOL-27062100006','2021-06-28','kredit',257033),
(81,'114','PM28062100011','2021-06-28','debet',4000000),
(82,'111','PM28062100011','2021-06-28','kredit',4000000),
(83,'113','PNR28062100008','2021-06-29','debet',185000),
(84,'111','PNR28062100008','2021-06-29','kredit',185000),
(85,'114','PM08092100012','2021-09-08','debet',225000),
(86,'111','PM08092100012','2021-09-08','kredit',225000),
(87,'113','PNR07092100009','2021-09-08','debet',275000),
(88,'111','PNR07092100009','2021-09-08','kredit',275000),
(89,'114','PM08092100013','2021-09-08','debet',90000),
(90,'111','PM08092100013','2021-09-08','kredit',90000),
(91,'113','PNR08092100010','2021-09-08','debet',140000),
(92,'111','PNR08092100010','2021-09-08','kredit',140000),
(93,'114','PM08092100014','2021-09-08','debet',10000000),
(94,'111','PM08092100014','2021-09-08','kredit',10000000),
(95,'113','PNR08092100011','2021-09-08','debet',11000000),
(96,'111','PNR08092100011','2021-09-08','kredit',11000000),
(97,'114','PM08092100015','2021-09-08','debet',100000000),
(98,'111','PM08092100015','2021-09-08','kredit',100000000),
(99,'113','PNR08092100012','2021-09-08','debet',100500000),
(100,'111','PNR08092100012','2021-09-08','kredit',100500000),
(101,'114','PM15092100016','2021-09-16','debet',5750000),
(102,'111','PM15092100016','2021-09-16','kredit',5750000),
(103,'113','PNR16092100013','2021-09-16','debet',7250000),
(104,'111','PNR16092100013','2021-09-16','kredit',7250000),
(105,'114','PM16092100017','2021-09-16','debet',7250000),
(106,'111','PM16092100017','2021-09-16','kredit',7250000),
(107,'113','PNR16092100014','2021-09-16','debet',8750000),
(108,'111','PNR16092100014','2021-09-16','kredit',8750000);

/*Table structure for table `kartu_stok` */

DROP TABLE IF EXISTS `kartu_stok`;

CREATE TABLE `kartu_stok` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keterangan` varchar(100) NOT NULL,
  `jml_masuk` int(11) NOT NULL,
  `harga` int(11) NOT NULL,
  `jml_keluar` int(11) NOT NULL,
  `hpp` int(11) NOT NULL,
  `jml_saldo` int(11) NOT NULL,
  `harga_saldo` int(11) NOT NULL,
  `id_barang` varchar(30) NOT NULL,
  `ukuran` enum('AllSize','XS','S','FitS','M','FitM','L','FitL','XL','FitXL','XXL','FitXXL') DEFAULT NULL,
  `tanggal` date NOT NULL,
  `id_transaksi` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4;

/*Data for the table `kartu_stok` */

insert  into `kartu_stok`(`id`,`keterangan`,`jml_masuk`,`harga`,`jml_keluar`,`hpp`,`jml_saldo`,`harga_saldo`,`id_barang`,`ukuran`,`tanggal`,`id_transaksi`) values 
(7,'Pembelian',30,77500,0,0,30,77500,'BR001',NULL,'2021-06-05','PNR05062100001'),
(8,'Pembelian',20,71250,0,0,20,71250,'BR002',NULL,'2021-06-05','PNR05062100001'),
(9,'Pembelian',3,77500,0,0,33,77500,'BR001',NULL,'2021-06-05','PNR05062100002'),
(10,'Pembelian',100,82500,0,0,33,77500,'BR001',NULL,'2021-06-05','PNR05062100003'),
(12,'Saldo Stok',0,0,0,0,100,82500,'BR001',NULL,'2021-06-05','PNR05062100003'),
(13,'Pembelian',30,77900,0,0,33,77500,'BR001',NULL,'2021-06-05','PNR05062100004'),
(14,'Saldo Stok',0,0,0,0,100,82500,'BR001',NULL,'2021-06-05','PNR05062100004'),
(15,'Saldo Stok',0,0,0,0,30,77900,'BR001',NULL,'2021-06-05','PNR05062100004'),
(16,'Penjualan Offline',0,0,10,77500,23,77500,'BR001',NULL,'2021-06-18','PNJF-28122000006'),
(17,'Saldo Stok',0,0,0,0,100,82500,'BR001',NULL,'2021-06-18','PNJF-28122000006'),
(18,'Saldo Stok',0,0,0,0,30,77900,'BR001',NULL,'2021-06-18','PNJF-28122000006'),
(19,'Penjualan Offline',0,0,3,71250,17,71250,'BR002',NULL,'2021-06-18','PNJF-28122000006'),
(20,'Penjualan Offline',0,0,3,77500,20,77500,'BR001',NULL,'2021-06-18','PNJF-18062100007'),
(21,'Saldo Stok',0,0,0,0,100,82500,'BR001',NULL,'2021-06-18','PNJF-18062100007'),
(22,'Saldo Stok',0,0,0,0,30,77900,'BR001',NULL,'2021-06-18','PNJF-18062100007'),
(23,'Penjualan Offline',0,0,2,71250,15,71250,'BR002',NULL,'2021-06-18','PNJF-18062100007'),
(24,'Pembelian',20,93000,0,0,20,93000,'BR003',NULL,'2021-06-18','PNR18062100005'),
(25,'Pembelian',100,70000,0,0,20,93000,'BR003',NULL,'2021-06-19','PNR19062100006'),
(26,'Saldo Stok',0,0,0,0,100,70000,'BR003',NULL,'2021-06-19','PNR19062100006'),
(27,'Pembelian',100,77000,0,0,100,77000,'BR004',NULL,'2021-06-19','PNR19062100006'),
(28,'Pembelian',99,77045,0,0,99,77045,'BR005',NULL,'2021-06-19','PNR19062100006'),
(29,'Pembelian',100,97000,0,0,100,97000,'BR006',NULL,'2021-06-19','PNR19062100006'),
(30,'Pembelian',109,83033,0,0,109,83033,'BR007',NULL,'2021-06-19','PNR19062100006'),
(31,'Penjualan Offline',0,0,2,77045,97,77045,'BR005',NULL,'2021-06-19','PNJF-19062100008'),
(32,'Penjualan Offline',0,0,1,77000,99,77000,'BR004',NULL,'2021-06-19','PNJF-19062100008'),
(33,'Penjualan Offline',0,0,1,97000,99,97000,'BR006',NULL,'2021-06-19','PNJF-19062100009'),
(34,'Penjualan Offline',0,0,1,83033,108,83033,'BR007',NULL,'2021-06-19','PNJF-19062100010'),
(35,'Penjualan Offline',0,0,1,93000,19,93000,'BR003',NULL,'2021-06-21','PNJF-21062100011'),
(36,'Saldo Stok',0,0,0,0,100,70000,'BR003',NULL,'2021-06-21','PNJF-21062100011'),
(37,'Penjualan Offline',0,0,1,93000,18,93000,'BR003',NULL,'2021-06-21','PNJF-21062100012'),
(38,'Saldo Stok',0,0,0,0,100,70000,'BR003',NULL,'2021-06-21','PNJF-21062100012'),
(39,'Penjualan Offline',0,0,1,77000,98,77000,'BR004',NULL,'2021-06-21','PNJF-21062100013'),
(40,'Penjualan Offline',0,0,1,77000,96,77000,'BR004',NULL,'2021-06-27','PNJOL-17062100003'),
(42,'Penjualan Online',0,0,1,77045,96,77045,'BR005',NULL,'2021-06-27','PNJOL-19062100004'),
(43,'Penjualan Online',0,0,1,77000,95,77000,'BR004',NULL,'2021-06-28','PNJOL-27062100006'),
(44,'Penjualan Online',0,0,1,97000,98,97000,'BR006',NULL,'2021-06-28','PNJOL-27062100006'),
(45,'Penjualan Online',0,0,1,83033,107,83033,'BR007',NULL,'2021-06-28','PNJOL-27062100006'),
(46,'Pembelian',100,48500,0,0,100,48500,'BR008',NULL,'2021-06-28','PNR28062100007'),
(47,'Pembelian',2,92500,0,0,20,77500,'BR001',NULL,'2021-06-29','PNR28062100008'),
(48,'Saldo Stok',0,0,0,0,100,82500,'BR001',NULL,'2021-06-29','PNR28062100008'),
(49,'Saldo Stok',0,0,0,0,30,77900,'BR001',NULL,'2021-06-29','PNR28062100008'),
(50,'Saldo Stok',0,0,0,0,2,92500,'BR001',NULL,'2021-06-29','PNR28062100008'),
(51,'Pembelian',5,55000,0,0,15,71250,'BR002',NULL,'2021-09-08','PNR07092100009'),
(52,'Saldo Stok',0,0,0,0,5,55000,'BR002',NULL,'2021-09-08','PNR07092100009'),
(53,'Pembelian',2,70000,0,0,15,71250,'BR002',NULL,'2021-09-08','PNR08092100010'),
(54,'Saldo Stok',0,0,0,0,5,55000,'BR002',NULL,'2021-09-08','PNR08092100010'),
(55,'Saldo Stok',0,0,0,0,2,70000,'BR002',NULL,'2021-09-08','PNR08092100010'),
(56,'Pembelian',100,110000,0,0,100,110000,'BR009',NULL,'2021-09-08','PNR08092100011'),
(57,'Pembelian',1000,100500,0,0,100,110000,'BR009',NULL,'2021-09-08','PNR08092100012'),
(58,'Saldo Stok',0,0,0,0,1000,100500,'BR009',NULL,'2021-09-08','PNR08092100012'),
(59,'Pembelian',100,72500,0,0,20,77500,'BR001',NULL,'2021-09-16','PNR16092100013'),
(60,'Saldo Stok',0,0,0,0,100,82500,'BR001',NULL,'2021-09-16','PNR16092100013'),
(61,'Saldo Stok',0,0,0,0,30,77900,'BR001',NULL,'2021-09-16','PNR16092100013'),
(62,'Saldo Stok',0,0,0,0,2,92500,'BR001',NULL,'2021-09-16','PNR16092100013'),
(63,'Saldo Stok',0,0,0,0,100,72500,'BR001',NULL,'2021-09-16','PNR16092100013'),
(64,'Pembelian',100,87500,0,0,100,87500,'BR004','AllSize','2021-09-16','PNR16092100014');

/*Table structure for table `kategori_barang` */

DROP TABLE IF EXISTS `kategori_barang`;

CREATE TABLE `kategori_barang` (
  `id` char(10) NOT NULL,
  `nama` varchar(200) NOT NULL,
  `gambar` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `kategori_barang` */

insert  into `kategori_barang`(`id`,`nama`,`gambar`) values 
('KB001','T-Shirts Collection','608bb705337b5.jpg'),
('KB002','Shirt Collection','608ba695b0c3b.jpg'),
('KB003','Jacket Collection','608b97d443064.jpg'),
('KB004','Pants Collection','608ba6da72561.jpg'),
('KB005','Pants ','60cdb9a425149.jpg');

/*Table structure for table `kategori_beban` */

DROP TABLE IF EXISTS `kategori_beban`;

CREATE TABLE `kategori_beban` (
  `id` char(10) NOT NULL,
  `nama_kategori` varchar(200) NOT NULL,
  `no_akun` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `kategori_beban` */

insert  into `kategori_beban`(`id`,`nama_kategori`,`no_akun`) values 
('KB001','Beban Listrik dan Air','511'),
('KB002','Beban Gaji Karyawan','512'),
('KB003','Beban Sewa Kantor','513'),
('KB004','Beban Iklan','514'),
('KB005','Beban Administrasi Lain-lain','515'),
('KB006','Beban Alat Tulis Kantor','518');

/*Table structure for table `logcart` */

DROP TABLE IF EXISTS `logcart`;

CREATE TABLE `logcart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cart` int(11) NOT NULL,
  `pelanggan_id` varchar(30) NOT NULL,
  `barang_id` varchar(30) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `id_transaksi` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4;

/*Data for the table `logcart` */

insert  into `logcart`(`id`,`id_cart`,`pelanggan_id`,`barang_id`,`jumlah`,`status`,`id_transaksi`) values 
(26,7,'PL008','BR005',1,3,'PNJOL-17062100002'),
(27,8,'PL008','BR004',1,3,'PNJOL-17062100003'),
(28,1,'PL012','BR005',1,3,'PNJOL-19062100004'),
(29,2,'PL013','BR006',1,3,'PNJOL-21062100005'),
(33,9,'PL006','BR004',1,3,'PNJOL-27062100006'),
(34,10,'PL006','BR006',1,3,'PNJOL-27062100006'),
(35,11,'PL006','BR007',1,3,'PNJOL-27062100006'),
(36,13,'PL006','BR005',3,3,'PNJOL-29062100007'),
(37,12,'PL006','BR006',3,3,'PNJOL-29062100007'),
(38,16,'PL006','BR005',1,2,''),
(39,15,'PL006','BR003',1,2,'');

/*Table structure for table `logsaldo` */

DROP TABLE IF EXISTS `logsaldo`;

CREATE TABLE `logsaldo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jml_saldo` int(11) NOT NULL,
  `hrg_saldo` int(11) NOT NULL,
  `id_barang` varchar(30) NOT NULL,
  `ukuran` enum('AllSize','XS','S','FitS','M','FitM','L','FitL','XL','FitXL','XXL','FitXXL') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

/*Data for the table `logsaldo` */

insert  into `logsaldo`(`id`,`jml_saldo`,`hrg_saldo`,`id_barang`,`ukuran`) values 
(3,20,77500,'BR001',NULL),
(4,15,71250,'BR002',NULL),
(5,100,82500,'BR001',NULL),
(6,30,77900,'BR001',NULL),
(7,18,93000,'BR003',NULL),
(8,100,70000,'BR003',NULL),
(9,95,77000,'BR004',NULL),
(10,96,77045,'BR005',NULL),
(11,98,97000,'BR006',NULL),
(12,107,83033,'BR007',NULL),
(13,100,48500,'BR008',NULL),
(14,2,92500,'BR001',NULL),
(15,5,55000,'BR002',NULL),
(16,2,70000,'BR002',NULL),
(17,100,110000,'BR009',NULL),
(18,1000,100500,'BR009',NULL),
(19,100,72500,'BR001',NULL),
(20,100,87500,'BR004','AllSize');

/*Table structure for table `pelanggan` */

DROP TABLE IF EXISTS `pelanggan`;

CREATE TABLE `pelanggan` (
  `id` char(10) NOT NULL,
  `nama` varchar(200) NOT NULL,
  `alamat` text NOT NULL,
  `email` varchar(100) NOT NULL,
  `nomor_telepon` char(20) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `level` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `pelanggan` */

insert  into `pelanggan`(`id`,`nama`,`alamat`,`email`,`nomor_telepon`,`username`,`password`,`level`) values 
('PL001','Doni','Jl. Budiman','','081223230946','','',0),
('PL002','Della Fadila Rahmawati','bandung\r\n','','081212126043','','',0),
('PL003','Nayaa','Jl. Sukapura','','081213012391','','',0),
('PL004','Reynaldo','Jl. Mangga Dua','','082291239102','','',0),
('PL005','Rundina','Jl. Telekomunikasi','','081200391201','','',0),
('PL006','Lady Diana','','diana@gmail.com','089657426022','ladyd','123456',5),
('PL007','Derby Norman','','derby@gmail.co','087231234','derby','123456',5),
('PL008','Naratama Putra','','naratama@gmail.com','0876783728','nara','123456',5),
('PL009','Dara Rahma','','dara@gmail.com','085224557654','dara','123456',5),
('PL010','Putri Firdha','','putri@gmail.com','085334567800','putri','123456',5),
('PL011','Prabu Siliwangi','Jl. Permai Bandung','','081888889977','','',0),
('PL012','Noval Pratama','','noval@gmail.com','086678665678','noval','123456',5),
('PL013','Sandi Astuti','','sandi@gmail.com','086675667899','sandi','123456',5);

/*Table structure for table `pemasok` */

DROP TABLE IF EXISTS `pemasok`;

CREATE TABLE `pemasok` (
  `id` char(10) NOT NULL,
  `nama` char(255) NOT NULL,
  `alamat` text NOT NULL,
  `nomor_telepon` char(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `pemasok` */

insert  into `pemasok`(`id`,`nama`,`alamat`,`nomor_telepon`) values 
('SP002','PT Vorteks Inti Persada','Jl. Kiaracondong','081223230941'),
('SP003','PT. Altra Multi Sandang','Jl. Buah Batu\r\n','081223230946'),
('SP004','Griya Textil Pasar Baru','Pasar Baru Mall Bandung Blok. A5','081213012391'),
('SP005','Cv. Kriya Textil Bandung','Jl. Dalam kaum No.51\r\n','0812339912391');

/*Table structure for table `pembayaran_beban` */

DROP TABLE IF EXISTS `pembayaran_beban`;

CREATE TABLE `pembayaran_beban` (
  `id_pembayaran` varchar(20) NOT NULL,
  `tgl_transaksi` date DEFAULT NULL,
  `id_kategori_beban` varchar(20) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `total_transaksi` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_pembayaran`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pembayaran_beban` */

insert  into `pembayaran_beban`(`id_pembayaran`,`tgl_transaksi`,`id_kategori_beban`,`keterangan`,`total_transaksi`) values 
('PYMNT-04062100003','2021-06-04','KB002',NULL,100000),
('PYMNT-19062100004','2021-06-19','KB002',NULL,90000),
('PYMNT-19062100005','2021-06-19','KB002',NULL,20000),
('PYMNT-20062100006','2021-06-20','KB006',NULL,20000),
('PYMNT-20062100007','2021-06-20','KB006',NULL,10000),
('PYMNT-26122000002','2020-12-26','KB001',NULL,150000);

/*Table structure for table `pembelian` */

DROP TABLE IF EXISTS `pembelian`;

CREATE TABLE `pembelian` (
  `id` char(20) NOT NULL,
  `tanggal_transaksi` date NOT NULL,
  `total_transaksi` double NOT NULL,
  `pemasok_id` char(10) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `pengadaan_id` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pembelian_pemasok_id_foreign` (`pemasok_id`),
  CONSTRAINT `pembelian_pemasok_id_foreign` FOREIGN KEY (`pemasok_id`) REFERENCES `pemasok` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `pembelian` */

insert  into `pembelian`(`id`,`tanggal_transaksi`,`total_transaksi`,`pemasok_id`,`status`,`pengadaan_id`) values 
('PM01052100001','2021-05-01',2625000,'SP002',4,'PG-01052100001'),
('PM05062100003','2021-06-05',5750000,'SP004',4,'PG-05062100003'),
('PM05062100004','2021-06-05',1725000,'SP003',4,'PG-05062100004'),
('PM05062100005','2021-06-05',1725000,'SP004',3,'PG-05062100005'),
('PM05062100006','2021-06-05',2875000,'SP005',3,'PG-05062100006'),
('PM08092100012','2021-09-08',225000,'SP002',4,'PG-07092100011'),
('PM08092100013','2021-09-08',90000,'SP002',4,'PG-08092100012'),
('PM08092100014','2021-09-08',10000000,'SP003',4,'PG-08092100013'),
('PM08092100015','2021-09-08',100000000,'SP003',4,'PG-08092100014'),
('PM15092100016','2021-09-16',5750000,'SP003',4,'PG-14092100015'),
('PM16092100017','2021-09-16',7250000,'SP004',4,'PG-16092100016'),
('PM16092100018','0000-00-00',0,NULL,1,''),
('PM18062100007','2021-06-18',115000,'SP003',3,'PG-18062100007'),
('PM18062100008','2021-06-18',1310000,'SP003',3,'PG-18062100008'),
('PM18062100009','2021-06-18',1310000,'SP003',3,'PG-18062100008'),
('PM19062100010','2021-06-19',38773100,'SP002',4,'PG-19062100009'),
('PM21052100002','2021-05-21',172500,'SP003',4,'PG-21052100002'),
('PM28062100011','2021-06-28',4000000,'SP003',4,'PG-28062100010');

/*Table structure for table `penerimaan` */

DROP TABLE IF EXISTS `penerimaan`;

CREATE TABLE `penerimaan` (
  `id_penerimaan` varchar(30) NOT NULL,
  `id_pengadaan` varchar(30) NOT NULL,
  `tanggal_transaksi` date NOT NULL,
  `total` double NOT NULL,
  `status` int(11) NOT NULL,
  `invoice` longtext NOT NULL,
  PRIMARY KEY (`id_penerimaan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `penerimaan` */

insert  into `penerimaan`(`id_penerimaan`,`id_pengadaan`,`tanggal_transaksi`,`total`,`status`,`invoice`) values 
('PNR05062100001','PG-01052100001','2021-06-05',3750000,2,''),
('PNR05062100002','PG-21052100002','2021-06-05',232500,2,''),
('PNR05062100003','PG-05062100003','2021-06-05',8250000,2,''),
('PNR05062100004','PG-05062100004','2021-06-05',2337000,2,''),
('PNR07092100009','PG-07092100011','2021-09-08',275000,2,'default.jpg'),
('PNR08092100010','PG-08092100012','2021-09-08',140000,2,'default.jpg'),
('PNR08092100011','PG-08092100013','2021-09-08',11000000,2,'default.jpg'),
('PNR08092100012','PG-08092100014','2021-09-08',100500000,2,'default.jpg'),
('PNR16092100013','PG-14092100015','2021-09-16',7250000,2,'61430c141c6d7.png'),
('PNR16092100014','PG-16092100016','2021-09-16',8749999.833107,2,'6143116a7abf0.jpg'),
('PNR16092100015','','0000-00-00',0,1,''),
('PNR18062100005','PG-18062100008','2021-06-18',1859999.9666214,2,''),
('PNR19062100006','PG-19062100009','2021-06-19',41078099.37048,2,''),
('PNR28062100007','PG-28062100010','2021-06-28',4850000,2,''),
('PNR28062100008','PG-18062100007','2021-06-29',185000,2,'default.jpg');

/*Table structure for table `pengadaan_barang` */

DROP TABLE IF EXISTS `pengadaan_barang`;

CREATE TABLE `pengadaan_barang` (
  `id_transaksi` varchar(20) NOT NULL,
  `tanggal_transaksi` date NOT NULL,
  `total` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `is_created` int(11) NOT NULL,
  PRIMARY KEY (`id_transaksi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pengadaan_barang` */

insert  into `pengadaan_barang`(`id_transaksi`,`tanggal_transaksi`,`total`,`status`,`is_created`) values 
('PG-01052100001','2021-05-01',0,3,2),
('PG-05062100003','2021-06-05',0,3,2),
('PG-05062100004','2021-06-05',0,3,2),
('PG-05062100005','2021-06-05',0,2,2),
('PG-05062100006','2021-06-05',0,2,2),
('PG-07092100011','2021-09-07',0,3,2),
('PG-08092100012','2021-09-08',0,3,2),
('PG-08092100013','2021-09-08',0,3,2),
('PG-08092100014','2021-09-08',0,3,2),
('PG-14092100015','2021-09-14',0,3,2),
('PG-16092100016','2021-09-16',0,3,2),
('PG-16092100017','2021-09-16',0,0,1),
('PG-18062100007','2021-06-18',0,3,2),
('PG-18062100008','2021-06-18',0,3,2),
('PG-19062100009','2021-06-19',0,3,2),
('PG-21052100002','2021-05-21',0,3,2),
('PG-28062100010','2021-06-28',0,3,2);

/*Table structure for table `penjualan` */

DROP TABLE IF EXISTS `penjualan`;

CREATE TABLE `penjualan` (
  `id` char(20) NOT NULL,
  `tanggal_transaksi` date NOT NULL,
  `total_transaksi` double NOT NULL,
  `pelanggan_id` char(20) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `penjualan_pelanggan_id_foreign` (`pelanggan_id`),
  CONSTRAINT `penjualan_pelanggan_id_foreign` FOREIGN KEY (`pelanggan_id`) REFERENCES `pelanggan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `penjualan` */

insert  into `penjualan`(`id`,`tanggal_transaksi`,`total_transaksi`,`pelanggan_id`,`status`) values 
('PNJF-18062100007','2021-06-18',390000,'PL005',4),
('PNJF-19062100008','2021-06-19',710000,'PL006',4),
('PNJF-19062100009','2021-06-19',225000,'PL002',4),
('PNJF-19062100010','2021-06-19',130000,'PL001',4),
('PNJF-21062100011','2021-06-21',150000,'PL001',4),
('PNJF-21062100012','2021-06-21',150000,'PL009',4),
('PNJF-21062100013','2021-06-21',250000,'PL011',4),
('PNJF-26122000004','2020-12-26',6750000,'PL001',4),
('PNJF-28122000005','2020-12-28',750000,'PL003',4),
('PNJF-28122000006','2021-06-18',725000,'PL003',4);

/*Table structure for table `penjualan_online` */

DROP TABLE IF EXISTS `penjualan_online`;

CREATE TABLE `penjualan_online` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` varchar(50) NOT NULL,
  `tanggal_transaksi` date NOT NULL,
  `id_pelanggan` varchar(30) NOT NULL,
  `total_transaksi` int(11) NOT NULL,
  `jenis_ekspedisi` varchar(100) NOT NULL,
  `nama_penerima` varchar(50) NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `kota` varchar(100) NOT NULL,
  `ongkir` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `notelp` varchar(15) NOT NULL,
  `batas_bayar` date NOT NULL,
  `status` int(11) NOT NULL,
  `bukti_bayar` longtext NOT NULL,
  `no_resi` varchar(200) NOT NULL,
  `bukti_resi` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

/*Data for the table `penjualan_online` */

insert  into `penjualan_online`(`id`,`id_transaksi`,`tanggal_transaksi`,`id_pelanggan`,`total_transaksi`,`jenis_ekspedisi`,`nama_penerima`,`alamat`,`kota`,`ongkir`,`email`,`notelp`,`batas_bayar`,`status`,`bukti_bayar`,`no_resi`,`bukti_resi`) values 
(11,'PNJOL-17062100002','2021-06-17','PL008',16000,'jne - REG','Reynaldo','Jl. Naratama','Bandung',246000,'diana@gmail.com','0823132432','0000-00-00',2,'','',''),
(12,'PNJOL-17062100003','2021-06-17','PL008',40000,'tiki - REG','Nara','Jl.jdasdjas','Bandar Lampung',290000,'naratama@gmail.com','0823132432','0000-00-00',6,'60cb502be62ff.jpg','43243242321313','60d87ba4d7a80.jpg'),
(13,'PNJOL-19062100004','2021-06-19','PL012',20000,'jne - OKE','Noval Pratama','Jl. Anggrek Raya','Cianjur',250000,'noval@gmail.com','085433786698','0000-00-00',6,'60ce031f32834.jpg','345435433443242','60d87ef611452.jpg'),
(14,'PNJOL-21062100005','2021-06-21','PL013',32000,'jne - OKE','sandi','Alamat*Jl. amanah no.8','Klaten',257000,'sandi@gmail.com','086675456678','0000-00-00',5,'60d036f776280.png','',''),
(15,'PNJOL-27062100006','2021-06-28','PL006',16000,'jne - REG','Ilham Muhammad','alamat','Bandung Barat',621000,'ilham@gmail.com','087676767','0000-00-00',6,'60d8b51d493fd.jpg','123423123213123','60d8b547ebaf2.jpg'),
(16,'PNJOL-29062100007','2021-06-29','PL006',16000,'jne - REG','Runida','jalan jalan','Bandung',1381000,'run@gmail.com','087665656','0000-00-00',2,'','',''),
(17,'PNJOL-29062100008','0000-00-00','',0,'','','','',0,'','','0000-00-00',1,'','','');

/*Table structure for table `perubahan_modal` */

DROP TABLE IF EXISTS `perubahan_modal`;

CREATE TABLE `perubahan_modal` (
  `id_modal` varchar(20) NOT NULL,
  `keterangan` varchar(50) DEFAULT NULL,
  `tgl_transaksi` date DEFAULT NULL,
  `total_transaksi` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_modal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `perubahan_modal` */

insert  into `perubahan_modal`(`id_modal`,`keterangan`,`tgl_transaksi`,`total_transaksi`) values 
('MD-04062100004','Penambahan Modal','2021-06-04',600000),
('MD-19062100005','Penambahan Modal','2021-06-19',100000),
('MD-19062100006','Penarikan Modal Untuk Kepentingan Pribadi','2021-06-19',50000),
('MD-26122000002','Penambahan Modal','2020-12-26',1000000),
('MD-28122000003','Penambahan Modal','2020-12-28',500000);

/*Table structure for table `transaksi` */

DROP TABLE IF EXISTS `transaksi`;

CREATE TABLE `transaksi` (
  `id` char(20) NOT NULL,
  `tanggal_transaksi` date NOT NULL,
  `total_transaksi` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `transaksi` */

insert  into `transaksi`(`id`,`tanggal_transaksi`,`total_transaksi`) values 
('MD-04062100004','2021-06-04',600000),
('MD-19062100005','2021-06-19',100000),
('MD-19062100006','2021-06-19',50000),
('MD-26122000002','2020-12-26',1000000),
('MD-28122000003','2020-12-28',500000),
('PG-01052100001','2021-05-01',0),
('PG-05062100003','2021-06-05',0),
('PG-05062100004','2021-06-05',0),
('PG-05062100005','2021-06-05',0),
('PG-05062100006','2021-06-05',0),
('PG-07092100011','2021-09-07',0),
('PG-08092100012','2021-09-08',0),
('PG-08092100013','2021-09-08',0),
('PG-08092100014','2021-09-08',0),
('PG-14092100015','2021-09-14',0),
('PG-16092100016','2021-09-16',0),
('PG-16092100017','2021-09-16',0),
('PG-18062100007','2021-06-18',0),
('PG-18062100008','2021-06-18',0),
('PG-19062100009','2021-06-19',0),
('PG-21052100002','2021-05-21',0),
('PG-24032100001','2021-03-24',0),
('PG-24032100002','2021-03-24',0),
('PG-24032100003','2021-03-24',0),
('PG-24032100004','2021-03-24',0),
('PG-28062100010','2021-06-28',0),
('PM01052100001','2021-05-01',2625000),
('PM05062100003','2021-06-05',5750000),
('PM05062100004','2021-06-05',1725000),
('PM05062100005','2021-06-05',1725000),
('PM05062100006','2021-06-05',2875000),
('PM07092100012','0000-00-00',0),
('PM08092100012','2021-09-08',225000),
('PM08092100013','2021-09-08',90000),
('PM08092100014','2021-09-08',10000000),
('PM08092100015','2021-09-08',100000000),
('PM15092100016','2021-09-16',5750000),
('PM16092100017','2021-09-16',7250000),
('PM16092100018','0000-00-00',0),
('PM18062100007','2021-06-18',115000),
('PM18062100008','2021-06-18',1310000),
('PM18062100009','2021-06-18',1310000),
('PM19062100010','2021-06-19',38773100),
('PM21052100002','2021-05-21',172500),
('PM28062100011','2021-06-28',4000000),
('PNJF-18062100007','2021-06-18',390000),
('PNJF-19062100008','2021-06-19',710000),
('PNJF-19062100009','2021-06-19',225000),
('PNJF-19062100010','2021-06-19',130000),
('PNJF-21062100011','2021-06-21',150000),
('PNJF-21062100012','2021-06-21',150000),
('PNJF-21062100013','2021-06-21',250000),
('PNJF-26122000004','2020-12-26',6750000),
('PNJF-28122000005','2020-12-28',750000),
('PNJF-28122000006','2021-06-18',725000),
('PYMNT-04062100003','2021-06-04',100000),
('PYMNT-19062100004','2021-06-19',90000),
('PYMNT-19062100005','2021-06-19',20000),
('PYMNT-20062100006','2021-06-20',20000),
('PYMNT-20062100007','2021-06-20',10000),
('PYMNT-26122000002','2020-12-26',150000);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_lengkap` varchar(200) NOT NULL,
  `username` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `level` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `user` */

insert  into `user`(`id`,`nama_lengkap`,`username`,`password`,`level`) values 
(1,'Rundina','rundina','123456',1),
(2,'Rey','rey','123456',2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
