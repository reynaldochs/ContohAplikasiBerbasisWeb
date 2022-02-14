<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Penjualan Online
            <small>data</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box">
                    <div class="box-header">
                        <!-- <a href="<?= site_url('penjualan/create') ?>" class="btn btn-primary"><i class="fa fa-plus"></i> Tambah Data</a> -->
                    </div>  
                    <!-- /.box-header -->
                    <div class="box-body">
                        <table id="example2" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                  <th>No</th>
                                  <th>ID penjualan</th>
                                  <th>Tanggal</th>
                                  <th>Nama Pelanggan</th>
                                  <th>Alamat Pengiriman</th>
                                  <th>Jenis Expedisi</th>
                                  <th>Total</th>
                                  <th>Ongkir</th>
                                  <th>Status</th>
                                  <th>Bukti Bayar</th>
                                  <th>No Resi</th>
                                  <th>Bukti Kirim</th>
                                  <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                    foreach($dataPenjualan as $index => $result) {
                                        ?>
                                            <tr>
                                                <td><?= $index + 1; ?></td>
                                                <td><?= $result->id_transaksi; ?></td>
                                                <td><?= date("d F Y", strtotime($result->tanggal_transaksi)); ?></td>
                                                <td><?= $result->nama; ?></td>
                                                <td><?= $result->kota; ?></td>
                                                <td><?= $result->jenis_ekspedisi; ?></td>
                                                <td><?= "Rp. ".number_format($result->ongkir-$result->total_transaksi, 0, ",", "."); ?></td>
                                                <td><?= "Rp. ".number_format($result->total_transaksi, 0, ",", "."); ?></td>
                                                <td>
                                                    <?php
                                                    $tgl_max = date('Y-m-d', strtotime('+1 days', strtotime($result->tanggal_transaksi)));
                                                    if(date('Y-m-d') > $tgl_max && $result->status ==2){ ?>
                                                        <label for="" class="label label-danger">Expired</label>
                                                   <?php }else{
                                                        if($result->status == 2) {
                                                            ?><label for="" class="label label-danger">Belum Bayar</label><?php
                                                        } else if($result->status == 3) {
                                                            ?><label for="" class="label label-warning">Sudah Bayar</label><?php
                                                        } else if($result->status == 4){
                                                            ?><label for="" class="label label-success">Dalam Proses Packing</label><?php
                                                        } else if($result->status == 5){
                                                            ?><label for="" class="label label-primary">Dalam Pengiriman</label>
                                                        <?php
                                                        }else{?>
                                                            <label for="" class="label label-info">Selesai</label>
                                                     <?php   }
                                                     }
                                                    ?>
                                                </td>
                                                <td class="text-center">
                                                    <a href="<?php echo base_url('upload/BuktiBayar/'.$result->bukti_bayar) ?>" class="perbesar">
                                                    <img src="<?php echo base_url('upload/BuktiBayar/'.$result->bukti_bayar) ?>" class="img-thumbnail" width="64" />
                                                  </td>
                                                <td><?= $result->no_resi; ?></td>
                                                <td class="text-center">
                                                    <a href="<?php echo base_url('upload/BuktiKirim/'.$result->bukti_resi) ?>" class="perbesar">
                                                    <img src="<?php echo base_url('upload/BuktiKirim/'.$result->bukti_resi) ?>" class="img-thumbnail" width="64" />
                                                  </td>
                                                <td>
                                                    <!-- <a href="<?= site_url('penjualan/show/'.$result->id_transaksi) ?>" class="btn btn-info btn-sm"><i class="fa fa-th"></i></a> -->
                                                    <?php 
                                                        $tgl_max = date('Y-m-d', strtotime('+1 days', strtotime($result->tanggal_transaksi)));
                                                        if(date('Y-m-d') > $tgl_max && $result->status ==2){ ?>
                                                        <a href="<?= site_url('penjualan_online/delete/'.$result->id_transaksi) ?>" class="btn btn-danger btn-sm"><i class="fa fa-trash"></i></a>
                                                    <?php }else{
                                                        if($result->status ==3) {
                                                            ?>
                                                            <a href="<?= site_url('penjualan_online/update_status/'.$result->id_transaksi) ?>" class="btn btn-success btn-sm"><i class="fa fa-check"></i> Confirm Order</a>
                                                            <?php
                                                        } elseif($result->status ==4){
                                                    ?>
                                                        <a href="<?= site_url('penjualan_online/done_packing/'.$result->id_transaksi) ?>" class="btn btn-primary btn-sm"><i class="fa fa-check"></i> Done Packing</a>
                                                    <?php
                                                        } elseif($result->status ==5){
                                                            $total = $result->ongkir-$result->total_transaksi;
                                                    ?>
                                                        <a href="#" class="btn btn-info btn-sm edit-modal" data-id="<?=  $result->id_transaksi; ?>" data-ongkir="<?= $total ?>" data-total="<?= $result->total_transaksi ?>"><i class="fa fa-check"></i> Delivered</a>

                                                        <!-- <a href="<?= site_url('penjualan_online/done/'.$result->id_transaksi.'/'.$total.'/'.$result->total_transaksi) ?>" class="btn btn-info btn-sm"><i class="fa fa-check"></i> Delivered</a> -->
                                                    <?php
                                                        }
                                                    }
                                                    ?>
                                                </td>
                                            </tr>
                                        <?php
                                    }
                                ?>
                            </tbody>
                        </table>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<div class="modal fade" id="resiModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Tambahkan No Resi</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">

              <form class="user" action="<?= site_url('penjualan_online/done'); ?>" method="POST" enctype="multipart/form-data">

                <div class="form-group">
                  <!-- <label>Kode Akun</label> -->
                  <input type="hidden" class="form-control" placeholder="Masukan disini." name="ongkir" id="total" value="">
                  <input type="hidden" class="form-control" placeholder="Masukan disini." name="total" id="ongkir" value="">
                </div>

                <div class="form-group">
                  <label>No Resi</label>
                  <input type="text" class="form-control" placeholder="Masukan disini." name="no_resi">
                </div>
                <div class="form-group">
                  <label>Bukti Pengiriman</label>
                  <input type="file" class="form-control" placeholder="Masukan disini." name="bukti">
                </div>
                
            </div>
            <div class="modal-footer">
              <button class="btn btn-primary" type="submit">Tambah</button>
              </form>
              <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
            </div>
          </div>
        </div>
</div>