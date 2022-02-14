<?php
    defined('BASEPATH') OR exit('No direct script access allowed');

    class Keuangan_model extends CI_Model 
    {
    	public function GenerateJurnal ($kode_akun, $id_transaksi, $posisi_dr_cr, $nominal)
		{
			$jurnal = array(
				'kode_akun'		=> $kode_akun,
				'id_transaksi'	=> $id_transaksi,
				'tgl_transaksi'	=> date('Y-m-d'),
				'posisi_dr_cr'	=> $posisi_dr_cr,
				'nominal'		=> $nominal,
				);
				$this->db->insert('jurnal',$jurnal);	
		}

		public function GetDataJurnal($where=[])
		{
			if(isset($_POST['tgl_awal'], $_POST ['tgl_akhir']))
			{
				$this->db->where('tgl_transaksi>=', $_POST['tgl_awal']);
				$this->db->where('tgl_transaksi <=', $_POST['tgl_akhir']);
			}
			$this->db->select('b.kode_akun, tgl_transaksi, nama_akun, a.posisi_dr_cr, nominal,id_transaksi');
			$this->db->from('jurnal a');
			$this->db->join('akun b', 'b.kode_akun = a.kode_akun');                                              
			if(!empty($where)) $this->db->where($where);
			// $this->db->order_by('a.id', 'asc');                                            
			// $this->db->order_by('id_transaksi');                                            
			$query = $this->db->get();
			return $query->result_array();	
		}
		public function getJurnalUmum($bulan,$tahun){
			// $bulan = str_pad($bulan,2,"0",STR_PAD_LEFT);
			// $waktu = $bulan."-".$tahun;
			$sql="	SELECT a.id_transaksi, a.tgl_transaksi,
				   a.posisi_dr_cr,a.nominal,b.nama_akun,a.kode_akun
				FROM jurnal a
				JOIN akun b ON (a.kode_akun=b.kode_akun) 
				WHERE MONTH(tgl_transaksi) = ".$bulan." AND YEAR(tgl_transaksi) = ".$tahun."
				ORDER BY id asc ";
				//echo $sql."<br>";
			$query = $this->db->query($sql);
			return $query->result_array();
		}
		public function getLapPemb(){
			$sql = "SELECT a.*,MONTHNAME(a.tanggal_transaksi) as bulan, YEAR(a.tanggal_transaksi) as tahun,sum(
						total_transaksi) as total 
					FROM pembelian a 
					GROUP BY MONTH(tanggal_transaksi), YEAR(tanggal_transaksi)";
			$query = $this->db->query($sql);
			return $query->result();
		}
		public function getLapPenj(){
			$sql = "SELECT a.*,MONTHNAME(a.tanggal_transaksi) as bulan, YEAR(a.tanggal_transaksi) as tahun,sum(
						total_transaksi) as total 
					FROM penjualan a 
					GROUP BY MONTH(tanggal_transaksi), YEAR(tanggal_transaksi)";
			$query = $this->db->query($sql);
			return $query->result();
		}
		public function getLapMutasi(){
			$this->db->select('id_barang, sum(jml_masuk) as masuk, sum(jml_keluar) as keluar, nama_barang');
			$this->db->join('barang', 'barang.id=kartu_stok.id_barang');
			$this->db->group_by('id_barang');
			$query = $this->db->get('kartu_stok');
			return $query->result();
		}
		public function GetSaldoAkun($kode_akun){
		//mengambil data saldo akun
			$this->db->where('kode_akun', $kode_akun);
			return $this->db->get('akun')->row_array();
		 }
		 public function getSaldoDebit($where = "", $order = ""){

	        if(!empty($where)) $this->db->where($where);
	        if(!empty($order)) $this->db->order_by($order);
			$this->db->where('a.posisi_dr_cr', 'debet');
			$this->db->select('sum(nominal) as saldo_awal_debit');
			$this->db->from('jurnal a');
			$query = $this->db->get(); 
			return $query->row();
		 }


		 public function getSaldoKredit($where = "", $order = ""){

	        if(!empty($where)) $this->db->where($where);
	        if(!empty($order)) $this->db->order_by($order);
			 $this->db->where('a.posisi_dr_cr', 'kredit');
			$this->db->select('sum(nominal) as saldo_awal_kredit');
			$this->db->from('jurnal a');
			$query = $this->db->get(); 
			return $query->row();
		 }
		 
	public function HitungJumlahBaris(){
		return $this->db->get('jurnal')->num_rows();

	   }

	
	public function GetDataAkun($where = "", $order = ""){
        if(!empty($where)) $this->db->where($where);
        if(!empty($order)) $this->db->order_by($order);
		return $this->db->get('akun')->result_array();
	 }

	 public function GetDataBukuBesar($kode_akun,$bln,$thn){
	 
		$this->db->where('month(tgl_transaksi)=', $bln);
	 
		$this->db->where('year(tgl_transaksi)=', $thn);
	 
	 $this->db->where('a.kode_akun', $kode_akun);
	 $this->db->select('a.kode_akun, tgl_transaksi, nama_akun, a.posisi_dr_cr, nominal');
	 $this->db->from('jurnal a');
	 $this->db->join('akun b', 'b.kode_akun = a.kode_akun');
	 $this->db->order_by('tgl_transaksi');
	 $query = $this->db->get(); 
	 return $query->result_array();
  }
		 public function getSaldoDebits($where = "", $order = ""){

	        if(!empty($where)) $this->db->where($where);
	        if(!empty($order)) $this->db->order_by($order);
			$this->db->where('a.posisi_dr_cr', 'debet');
			$this->db->select('sum(nominal) as saldo_awal_debit');
			$this->db->from('jurnal a');
			$query = $this->db->get(); 
			return $query->row();
		 }


		 public function getSaldoKredits($where = "", $order = ""){

	        if(!empty($where)) $this->db->where($where);
	        if(!empty($order)) $this->db->order_by($order);
			 $this->db->where('a.posisi_dr_cr', 'kredit');
			$this->db->select('sum(nominal) as saldo_awal_kredit');
			$this->db->from('jurnal a');
			$query = $this->db->get(); 
			return $query->row();
		 }
		 public function getSaldoLaba($bulan,$tahun){		 	
            $this->db->where('MONTH(tgl_transaksi)', $bulan)
                    ->where('YEAR(tgl_transaksi)', $tahun)
                    ->where('header_akun', 4)
                    ->where('posisi_dr_cr', 'debet')
                    ->select('sum(nominal) as saldo_debet')
                    ->from('jurnal')
                    ->join('akun','jurnal.kode_akun=akun.kode_akun')
                    ->group_by('header_akun');
            $query = $this->db->get(); 
			if($query->row_array() != null){
				$saldo_pendapatan_debet =  $query->row_array()['saldo_debet'];
			}else{
				$saldo_pendapatan_debet =0;
			}
            $this->db->where('MONTH(tgl_transaksi)', $bulan)
                    ->where('YEAR(tgl_transaksi)', $tahun)
                    ->where('header_akun', 4)
                    ->where('posisi_dr_cr', 'kredit')
                    ->select('sum(nominal) as saldo_kredit')
                    ->from('jurnal')
                    ->join('akun','jurnal.kode_akun=akun.kode_akun')
                    ->group_by('header_akun');
            $query = $this->db->get(); 
			if($query->row_array() != null){
				$saldo_pendapatan_kredit =  $query->row_array()['saldo_kredit'];
			}else{
				$saldo_pendapatan_kredit=0;
			}
            $this->db->where('MONTH(tgl_transaksi)', $bulan)
                    ->where('YEAR(tgl_transaksi)', $tahun)
                    ->where('header_akun', 5)
                    ->where('posisi_dr_cr', 'debet')
                    ->select('sum(nominal) as saldo_debet')
                    ->from('jurnal')
                    ->join('akun','jurnal.kode_akun=akun.kode_akun')
                    ->group_by('header_akun');
            $query = $this->db->get(); 
			if($query->row_array() != null){
				$saldo_beban_debet =  $query->row_array()['saldo_debet'];
			}else{
				$saldo_beban_debet=0;
			}
            $this->db->where('MONTH(tgl_transaksi)', $bulan)
                    ->where('YEAR(tgl_transaksi)', $tahun)
                    ->where('header_akun', 5)
                    ->where('posisi_dr_cr', 'kredit')
                    ->select('sum(nominal) as saldo_kredit')
                    ->from('jurnal')
                    ->join('akun','jurnal.kode_akun=akun.kode_akun')
                    ->group_by('header_akun');
            $query = $this->db->get(); 
			if($query->row_array() != null){
				$saldo_beban_kredit =  $query->row_array()['saldo_kredit'];
			}else{
				$saldo_beban_kredit=0;
			}
            
            $saldo = ($saldo_pendapatan_debet+$saldo_pendapatan_kredit) - ($saldo_beban_debet-$saldo_beban_kredit);
            return $saldo;
		 }


	    public function getStokLast($id_barang){
	    	$this->db->where('id_barang',$id_barang)
	    			->order_by('id','DESC')
	               ->limit(1);
	    	return $this->db->get('kartu_stok')->row();
	    }


		public function getKartuStok($idbrg){
			$where = array('kartu_stok.id_barang' => $idbrg,
							// 'MONTH(tanggal)' => $bulan,
							// 'YEAR(tanggal)' => $tahun
							 );
		    $this->db->select('*')
		            ->join('barang', 'barang.id = kartu_stok.id_barang')
		            ->where($where);
		    return $this->db->order_by('tanggal, RIGHT(id_transaksi,5), kartu_stok.id')->get('kartu_stok')->result_array();
		}

		public function saldo_awal_buku_besar($akun,$bln,$thn)
		{
			$periode = $thn.'-'.str_pad($bln,2,'0',STR_PAD_LEFT);
			$q = "SELECT IFNULL(SUM(nominal_dr),0) as tot_dr, IFNULL(SUM(nominal_cr),0) as tot_cr FROM
					((SELECT
							nominal as nominal_dr,
							0 AS nominal_cr
						FROM
							jurnal
						WHERE
							kode_akun = '$akun'
						AND date_format(tgl_transaksi, '%Y-%m') < '$periode'
						AND posisi_dr_cr = 'debet')
					UNION ALL 
					(SELECT
							0 AS nominal_dr,
							nominal AS nominal_cr
						FROM
							jurnal
						WHERE
							kode_akun = '$akun'
						AND date_format(tgl_transaksi, '%Y-%m') < '$periode'
						AND posisi_dr_cr = 'kredit')) ut";
			$q = $this->db->query($q);
			return $q->row();
		}
		
		public function dataDetailPembelian($periode)
        {
			$periode = date('Y-m',strtotime($periode));
			//mengambil data deatail transaksi/ daftar belanja
			$this->db->select('detail_pembelian.*, pembelian.tanggal_transaksi , bahan_baku.nama_bahan_baku, bahan_baku.id as id_bahan_baku, satuan');
			$this->db->from('detail_pembelian');
			$this->db->join('pembelian', 'detail_pembelian.pembelian_id = pembelian.id');
			$this->db->join('bahan_baku', 'bahan_baku.id = detail_pembelian.bahan_baku_id');
			$this->db->where("date_format(tanggal_transaksi, '%Y-%m') = '$periode'");
			$query = $this->db->get();	
			return $query->result();
        }
    }
?>