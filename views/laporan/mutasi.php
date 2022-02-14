<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Mutasi Barang Dagang
            <small>data</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box">
                    <div class="box-header">
                    <center>
                        <h3>Bandung Clothing Corporatian</h3>
                        <h3>Mutasi Barang Dagang</h3>
                    </center>
                    </div>  
                    <!-- /.box-header -->
                    <div class="box-body">
                        <table id="example2" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                  <th>No</th>
                                  <th>ID Barang</th>
                                  <th>Nama Barang</th>
                                  <th>Jumlah Masuk</th>
                                  <th>Jumlah Keluar</th>
                                  <th>Stok</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                    foreach($result as $index => $data) {
                                        ?>
                                            <tr>
                                                <td><?= $index + 1 ?></td>
                                                <td><?= $data->id_barang?></td>
                                                <td><?= $data->nama_barang?></td>
                                                <td><?= $data->masuk?></td>
                                                <td><?= $data->keluar?></td>
                                                <td><?= $data->masuk-$data->keluar?></td>
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