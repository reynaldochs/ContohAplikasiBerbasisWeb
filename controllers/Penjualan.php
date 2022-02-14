<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Penjualan extends CI_Controller
{
    function __construct()
    {
        parent::__construct();
        date_default_timezone_set('Asia/Jakarta');

        if(!$this->session->userdata("username")) redirect("login");

        $this->load->model('Penjualan_model');
        $this->load->model('Pelanggan_model');
        $this->load->model('Barang_model');
        $this->load->model('Keuangan_model');
    }

    function index()
    {
        $data['dataPenjualan'] = $this->Penjualan_model->readPenjualan();
        $data['view'] = "penjualan/index";
        $this->load->view('index', $data);
    }

    function create()
    {
        $id = $this->Penjualan_model->kode_penjualan();
        $data['view'] = "penjualan/create";
        $data['kode_penjualan'] = $id;
        $data['dataDetail'] = $this->Penjualan_model->readDetailPenjualan($id);
        $data['dataBarang'] = $this->Barang_model->read();
        $data['dataPelanggan'] = $this->Pelanggan_model->read();
        $this->load->view('index', $data);

    }

    function store()
    {
        $dataStore = array(
            'id' => $this->Penjualan_model->kode_penjualan(),
            'nama' => $this->input->post('nama'),
            'alamat' => $this->input->post('alamat'),
            'nomor_telepon' => $this->input->post('nomor_telepon')
        );
        $this->Penjualan_model->create($dataStore);

        redirect('penjualan');
        
    }

    function edit($id)
    {
        $result = $this->Penjualan_model->read("id = '$id'");
        $data['penjualan'] = $result[0];
        $data['view'] = "penjualan/edit";
        $this->load->view('index', $data);
    }

    function show($id) 
    {
        $data['dataDetail'] = $this->Penjualan_model->readDetailPenjualan($id);
        $data['penjualan'] = $this->Penjualan_model->read("id = '$id'")[0];
        $data['view'] = "penjualan/show";
        $this->load->view('index', $data);
    }

    function update($id)
    {
        $dataStore = array(
            'nama' => $this->input->post('nama'),
            'alamat' => $this->input->post('alamat'),
            'nomor_telepon' => $this->input->post('nomor_telepon')
        );

        $this->Penjualan_model->update("id = '$id'", $dataStore);
        return redirect('penjualan');
    }

    function deleteitem($id,$brg,$jml)
    {
        $this->db->from('detail_penjualan');
        $this->db->where("id = '$id'");
        $this->db->delete();

        $stok = $this->Penjualan_model->getStok($brg);
        $stok2 = $stok+$jml;
        $this->db->where("id", $brg);
        $this->db->set('stok', $stok2);
        $this->db->update('barang');

        redirect('penjualan/create');
    }

    function simpanbarang()
    {
        $stok = $this->Penjualan_model->getStok($this->input->post('barang_id'));
        $jumlah = $this->input->post('jumlah_penjualan');
        if ($stok < $jumlah) {
            $this->session->set_flashdata('error_msg', 'Stok barang tidak mencukupi.');
            redirect('penjualan/create');
        }else{
            $stok2 = $stok-$jumlah;
                $this->db->where('id', $this->input->post('barang_id'));
                $this->db->set('stok', $stok2);
                $this->db->update('barang');

            $this->Penjualan_model->InsertDetail();
            redirect('penjualan/create');
        }
    }

    function penjualanselesai()
    {
        $id= $this->input->post('id');
		$this->Penjualan_model->selesaiPenjualan($id, $this->input->post('pelanggan_id'));
        $save = array('status'=>3);
        $this->db->where('id', $id);
        $this->db->update('penjualan',$save);

        $nominal = $this->Penjualan_model->getTotalTransaksi($id);
        // $hpp = $this->Penjualan_model->getHPP($id);
        // $hpp_n = round($hpp['nominal'],2);

        $detail_penjualan = $this->Penjualan_model->readDetailPenjualan($id);
        $hpp = 0;
        foreach ($detail_penjualan as $key) {
            $this->db->select('*')
                    ->from('logsaldo')
                    ->where(array('id_barang'=>$key->id_barang, 'jml_saldo>'=>0))
                    ->order_by('id','ASC')
                    ->limit('1');
            $qry = $this->db->get()->row();
            $harga_brg = $key->jumlah_penjualan*$qry->hrg_saldo;
            $hpp = $hpp+$harga_brg;

            $this->db->where('id',$qry->id)
                    ->set('jml_saldo','jml_saldo-'.$key->jumlah_penjualan."",FALSE)   
                    ->update('logsaldo');

            $this->db->where(array('id_barang'=>$key->id_barang, 'jml_saldo >'=>0 ))
                                ->order_by('id','ASC')
                               ->limit(1);
                        $saldo = $this->db->get('logsaldo')->row();
                        $dataStok = array('keterangan' => 'Penjualan Offline' ,
                                            'id_barang' => $key->id_barang,
                                            'jml_masuk' => 0,
                                            'harga'     => 0,
                                            'jml_keluar' => $key->jumlah_penjualan,
                                            'hpp' => $saldo->hrg_saldo,
                                            'jml_saldo' => $saldo->jml_saldo,
                                            'harga_saldo' => $saldo->hrg_saldo,
                                            'tanggal' => date('Y-m-d'),
                                            'id_transaksi' => $id
                                        );
                        $this->db->insert('kartu_stok',$dataStok);

                        $this->db->where(array('id !='=>$saldo->id,'id_barang'=>$key->id_barang, 'jml_saldo >'=>0 ));
                        $kartu = $this->db->get('logsaldo')->result_array();
                        foreach ($kartu as $b) {
                            $datakartu = array('keterangan' => 'Saldo Stok' ,
                                                'id_barang' => $key->id_barang,
                                                'jml_masuk' => 0,
                                                'harga'     => 0,
                                                'jml_keluar' => 0,
                                                'hpp' => 0,
                                                'jml_saldo' => $b['jml_saldo'],
                                                'harga_saldo' => $b['hrg_saldo'],
                                                'tanggal' => date('Y-m-d'),
                                                'id_transaksi' => $id
                                            );
                            $this->db->insert('kartu_stok',$datakartu);

                        }
        }

        //generate jurnal
        $this->Keuangan_model->generateJurnal('111', $id, 'debet', $nominal);
        $this->Keuangan_model->generateJurnal('411', $id, 'kredit', $nominal);
        $this->Keuangan_model->GenerateJurnal('516', $id, 'debet', $hpp);
        $this->Keuangan_model->GenerateJurnal('113', $id, 'kredit', $hpp);


        $this->db->where('id',$id);
        $qry = $this->db->get('detail_penjualan')->result_array();

        
        
		redirect('penjualan');
    }

    // function updatestatus($id)
    // {
    //     $this->Penjualan_model->update("id = '$id'", array('status' => 4));
    //     redirect('penjualan');
    // }
}

?>