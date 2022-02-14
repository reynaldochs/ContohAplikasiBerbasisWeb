<?php
	class pmodal_model extends CI_Model
	{
		private $table="perubahan_modal";


		public function kode()
	    {
	    	$this->db->select('RIGHT('.$this->table.'.id_pmb_modal,3) as kode', FALSE);
	        $this->db->order_by('id_pmb_modal','DESC');
	        $this->db->limit(1);

	        $query=$this->db->get($this->table);

	        if ($query->num_rows()!=0) 
	        {
	           $data=$query->row();
	           $kode=intval($data->kode)+1;
	        } 
	        else
	        {
	            $kode=1;
	        }
	        $kode_max=str_pad($kode,3,"0",STR_PAD_LEFT);
	        $fix_code="PRM-".$kode_max;
	        return $fix_code;
	    }

		public function getData(){
			$this->db->select('*')
					->from($this->table);
			$qry = $this->db->get();
			return $qry->result_array();
		}
		public function lastData(){
			$this->db->select('*')
					->from($this->table)
					->order_by('id_pengeluaran', 'DESC')
					->limit('1');
			$qry = $this->db->get();
			return $qry->row();
		}

		public function setAkun($ket){
			if ($ket == "Penambahan Modal") {
				return 311;
			}elseif ($ket == "Pengurangan Modal Untuk Aktifitas Pribadi") {
				return 312;
			}
		}
		public function getDetailFaktur($id){
			$this->db->select('*')
					->from($this->table)
					->where($this->table.'.id_pengeluaran', $id)
					->join($this->table2, $this->table2.'.id_pengeluaran='.$this->table2.'.id_pengeluaran')
					->join('kategori_beban', $this->table2.'.id_beban=kategori_beban.id_beban');
			$qry = $this->db->get();
			return $qry->result_array();
		}

		public function InsertDetail($data){
	        $this->db->insert($this->table2,$data);
			if($this->db->affected_rows() > 0){
		         return true;
		      }
		      return false;
	    }
	    public function getAkunBeban($id){
	    	$this->db->select('*')
	    			->from($this->table2)
	    			->join('kategori_beban','kategori_beban.id_beban='.$this->table2.'.id_beban')
	    			->where('id_pengeluaran',$id);
	    	$qry = $this->db->get();
	    	return $qry->result_array();
	    }
	}
?>