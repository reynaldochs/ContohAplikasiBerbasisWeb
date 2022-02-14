<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Laporan Pembelian
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
                        <h3>Laporan Pembelian Bahan Baku Bulanan</h3>
                        <h3>Semua Periode</h3>
                    </center>
                    </div>  
                    <!-- /.box-header -->
                    <div class="box-body">
                        <table id="example2" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                  <th>No</th>
                                  <th>Periode</th>
                                  <th>Total Pembelian</th>
                                  <th>Detail</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                    foreach($result as $index => $data) {
                                        ?>
                                            <tr>
                                                <td><?= $index + 1 ?></td>
                                                <td><?= $data->bulan." - ".$data->tahun?></td>
                                                <td><?= 'Rp. '.number_format($data->total, 0, ",",".") ?></td>
                                                <td><button type="button" class="btn btn-info" onclick="loadDetail('<?= $data->tanggal_transaksi ?>')" id="btnDetail"><i class="fa fa-th"></i></button></td>
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


<!-- Modal -->
<div class="modal fade" id="modalDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Detail Pembelian</h4>
      </div>
      <div class="modal-body">
        <div id="target-detail" style="overflow:auto;"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script>
    window.onload = function(){
    }

    function loadDetail(periode){
        $.ajax({
            url:"<?=site_url('keuangan/lapPembDetail')?>",
            type:"get",
            data:{periode},
            dataType:"html",
            beforeSend(){
                $("#modalDetail").modal('show');
            },
            success(page){
                $("#target-detail").html(page);
            },
            error(){

            }
        });
    }        

</script>