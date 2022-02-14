<?php
    defined('BASEPATH') OR exit('No direct script access allowed');

    class Dashboard_model extends CI_Model 
    {
        function countOnline(){
            return $this->db->where('status',3)->get("penjualan_online")->num_rows();
        }
        function sumPenjualan(){
            $bln = date('m');
            $thn = date('Y');
            return $this->db->where(array('status >='=>3, 'MONTH(tanggal_transaksi)'=>$bln, 'YEAR(tanggal_transaksi)'=>$thn))->select('SUM(total_transaksi) as total')->get("penjualan")->result();
        }
        function sumPenerimaan(){
            $bln = date('m');
            $thn = date('Y');
            return $this->db->where(array('status >='=>2, 'MONTH(tanggal_transaksi)'=>$bln, 'YEAR(tanggal_transaksi)'=>$thn))->select('SUM(total) as total')->get("penerimaan")->result();
        }

        function count()
        {
            return $this->db->get("akun")->num_rows();
        }

        function read($where = "", $order = "") 
        {
            if(!empty($where)) $this->db->where($where);
            if(!empty($where)) $this->db->order_by($order);

            $query = $this->db->get("akun");

            if($query AND $query->num_rows() != 0) {
                return $query->result();
            } else {
                return array();
            }
        }

        function update($id, $data)
        {
            $this->db->where($id);
            $this->db->update("akun", $data);
        }

        function delete($id)
        {
            $this->db->where($id);
            $this->db->delete("akun");
        }
    }
?>