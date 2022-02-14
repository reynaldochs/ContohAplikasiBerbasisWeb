<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Dashboard extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();
        date_default_timezone_set('Asia/Jakarta');
        if(!$this->session->userdata("username")) redirect("login");
		$this->load->model('Dashboard_model');
    }
    
    function index()
    {
        $data['online'] = $this->Dashboard_model->countOnline();
        $data['penjualan'] = $this->Dashboard_model->sumPenjualan()[0]->total;
        $data['penerimaan'] = $this->Dashboard_model->sumPenerimaan()[0]->total;
        $data['view'] = "dashboard/index";
        $this->load->view('index', $data);
    }
}

?>