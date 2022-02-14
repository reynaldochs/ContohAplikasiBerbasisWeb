<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Detail Penerimaan
            <small>data</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box">
                    <div class="box-header">
                        <a href="<?= site_url('penerimaan') ?>" class="btn btn-success"><i class="fa fa-chevron-left"></i> Kembali</a>
                    </div>  
                    <!-- /.box-header -->
                    <div class="box-body">
                        <table class="table">
                            <tr>
                                <th width="250px">Kode Penerimaan</th>
                                <td width="50px">:</td>
                                <td><?= $penerimaan->id_penerimaan ?></td>
                            </tr>
                            <tr>
                                <th>Tanggal Penerimaan</th>
                                <td>:</td>
                                <td><?= date('d F Y', strtotime($penerimaan->tanggal_transaksi)) ?></td>
                            </tr>
                            <tr>
                                <th>Total Pembelian</th>
                                <td>:</td>
                                <td>Rp. <?= number_format($penerimaan->total, 0, ",", ".") ?></td>
                            </tr>
                        </table>
                        <br>
                        <br>


                        <div class="box-title">
                            <h3>Detail Bahan Baku</h3>
                        </div>
                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Nama Barang</th>
                                    <th>Kode Bahan Baku</th>
                                    <th>Bahan</th>
                                    <th>Jenis Bahan</th>
                                    <th>Jumlah Pengadaan</th>
                                    <th>Satuan</th>
                                    <th>Harga Satuan</th>
                                    <th>Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                    foreach($dataKebutuhan as $index => $result) {
                                        $jumlah =$result->qty*$result->komposisi;
                                        ?>
                                            <tr>
                                                <td><?= $index + 1; ?></td>
                                                <td><?= $result->nama_barang; ?></td>
                                                <td><?= $result->bahan_baku_id; ?></td>
                                                <td><?= $result->nama_bahan_baku; ?></td>
                                                <td><?= $result->keterangan; ?></td>
                                                <td><?= $jumlah; ?></td>
                                                <td><?= $result->satuan; ?></td>
                                                <td><?= "Rp. ".number_format($result->harga_satuan); ?></td>
                                                <td><?= "Rp. ".number_format($jumlah*$result->harga_satuan); ?></td>
                                            </tr>
                                        <?php
                                    }
                                ?>
                            </tbody>
                        </table>

                        <div class="box-title">
                            <h3>Detail Penerimaan</h3>
                        </div>
                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Kode Barang</th>
                                    <th>Nama Barang</th>
                                    <th>Ukuran</th>
                                    <th>Jumlah</th>
                                    <th>Total Biaya Bahan Baku</th>
                                    <th>Total Biaya Produksi (BTKL & BOP)</th>
                                    <th>Total Biaya Lainnya</th>
                                    <th>Sub Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                    $subtotal = 0;
                                    $total = 0;
                                    foreach($dataDetail as $index => $result) {
                                        $subtotal = $result->biaya_bahan_baku+$result->biaya_produksi+$result->biaya_tambahan;
                                        $total = $total+$subtotal;
                                        $biaya = $subtotal/$result->qty;
                                        ?>
                                            <tr>
                                                <td><?= $index + 1; ?></td>
                                                <td><?= $result->id_barang; ?></td>
                                                <td><?= $result->nama_barang; ?></td>
                                                <td><?= $result->ukuran; ?></td>
                                                <td><?= $result->qty; ?></td>
                                                <td><?= "Rp. ".number_format($result->biaya_bahan_baku, 0, ",", "."); ?></td>
                                                <td><?= "Rp. ".number_format($result->biaya_produksi, 0, ",", "."); ?></td>
                                                <td><?= "Rp. ".number_format($result->biaya_tambahan, 0, ",", ".") ?></td>
                                                <td align="right"><?= "Rp. ".number_format($subtotal, 0, ",", ".") ?></td>
                                            </tr>
                                        <?php
                                    }
                                ?>
                                <tr>
                                    <td colspan="6"><b>Total Transaksi</b></td>
                                    <td colspan="2" align="right"><b><?= "Rp. ".number_format($total, 0, ",", ".") ?></b></td>
                                </tr>
                            </tbody>
                        </table>

                        <div class="box-title">
                            <h3>Detail Biaya Per 1 Barang</h3>
                        </div>
                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Kode Barang</th>
                                    <th>Nama Barang</th>
                                    <th>Ukuran</th>
                                    <th>Jumlah</th>
                                    <th>Biaya Bahan Baku/1 Barang <br>
                                    (tot.biy bahan baku:jumlah)</th>
                                    <th>Biaya Produksi (BTKL & BOP)/1 Barang <br>
                                    ((tot.biy produksi:tot bhn baku)*jml bahan baku/1 barang)</th>
                                    <th>Biaya Lainnya/1 Barang <br>
                                    (tot.biy lainnya:jumlah)</th>
                                    <th>Harga Pokok Barang</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                    $subtotal = 0;
                                    $total = 0;
                                    foreach($dataDetail as $index => $result) {
                                        $subtotal = $result->biaya_bahan_baku+$result->biaya_produksi+$result->biaya_tambahan;
                                        $total = $total+$subtotal;
                                        $biaya = $subtotal/$result->qty;
                                        ?>
                                            <tr>
                                                <td><?= $index + 1; ?></td>
                                                <td><?= $result->id_barang; ?></td>
                                                <td><?= $result->nama_barang; ?></td>
                                                <td><?= $result->ukuran; ?></td>
                                                <td><?= $result->qty; ?></td>
                                                <td><?php $biybhn= $result->biaya_bahan_baku/$result->qty;
                                                 echo "Rp. ".number_format($biybhn, 0, ",", "."); ?></td>
                                                <td><?php
                                                    $this->db->where(array('keterangan' =>"Bahan Baku",'barang_id'=>$result->id_barang));
                                                    $this->db->select('*');
                                                    $this->db->from('bom a');
                                                    $this->db->join('detail_bom b','a.id=b.bom_id');
                                                    $qry = $this->db->get()->result();
                                                    foreach ($qry as $bom) {
                                                        $kom =$bom->komposisi;
                                                        $bhn = $result->qty*$kom;
                                                    }
                                                    $biy = ($result->biaya_produksi/$bhn)*$kom;
                                                    echo "Rp. ".number_format($biy, 0, ",", "."); 
                                                ?></td>
                                                <td><?php
                                                    $biytmb =$result->biaya_tambahan/$result->qty;
                                                    echo "Rp. ".number_format($biytmb, 0, ",", ".");
                                                    $all = $biybhn+$biytmb+$biy; ?></td>
                                                <td align="right"><?= "Rp. ".number_format($all, 0, ",", ".") ?></td>
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