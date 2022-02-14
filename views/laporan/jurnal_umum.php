<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Jurnal Umum
            <small>data</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box">
                    <!-- /.box-header -->
                    <div class="box-body">
                    <form align="center" method="post" action="<?php echo site_url().'/keuangan/jurnal' ?> " class="form-inline">
            		<div class="row">
            			<div class="col-sm-4">
            				<div class="form-group">
                                                <label>Bulan</label>
                                                <select name="bulan" class="form-control">
                                                    <option value="" disabled selected>Pilih Bulan</option>
                                                    <option value="01">Jan</option>
                                                    <option value="02">Feb</option>
                                                    <option value="03">Mar</option>
                                                    <option value="04">Apr</option>
                                                    <option value="05">Mei</option>
                                                    <option value="06">Jun</option>
                                                    <option value="07">Jul</option>
                                                    <option value="08">Agt</option>
                                                    <option value="09">Sept</option>
                                                    <option value="10">Okt</option>
                                                    <option value="11">Nov</option>
                                                    <option value="12">Des</option>
                                                </select>
                                            </div>
            			</div>
            			<div class="col-sm-4">
                           <div class="form-group">
                                                <label>Tahun</label>
                                                <select name="tahun" class="form-control">
                                                    <option value="" disabled selected>Pilih Tahun</option> <?php for ($i=2020; $i < 2025; $i++) {
                                                        echo "<option value". $i.">".$i."</option>"; } ?>
                                                </select>
                                            </div>
            			</div>
            			<div class="col-sm-4"><br>
                        	<input type="submit" value="filter" name="submit" class="btn btn-info">
            			</div>
            			
            		</div>
                </form>
                <br>
<div class="row">
		<div class="col-sm-12" style="background-color:white;" align="center">
					<b>Bandung Clothing Corporation</b>
		</div>
		<div class="col-sm-12" style="background-color:white;" align="center">
					<b>Jurnal Umum</b>
		</div>
		<div class="col-sm-12" style="background-color:white;" align="center">
				<b>Periode <?php echo date('M', strtotime($tanggal))." ".$tahun; ?></b>
		</div>
	</div>
        <p>
		<p>
  <table class="table table-bordered">
    <thead>
      <tr>
        <th>Id Transaksi</th>
        <th>Tanggal</th>
        <th>Keterangan</th>
		<th>Ref</th>
		<th>Debet</th>
		<th>Kredit</th>
      </tr>
    </thead>
    <tbody>
     <?php
     $saldodb=0; $saldokr=0;
		foreach($jurnal as $cacah):
				echo "<tr>";
					echo "<td>".$cacah['id_transaksi']."</td>";
					echo "<td>".$cacah['tgl_transaksi']."</td>";
					if(strcmp($cacah['posisi_dr_cr'],'debet')==0){
						echo "<td>".$cacah['nama_akun']."</td>";
					}
					else{
						echo "<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;".$cacah['nama_akun']."</td>";	
					}
					
					echo "<td>".$cacah['kode_akun']."</td>";
					if(strcmp($cacah['posisi_dr_cr'],'debet')==0){
                        $saldodb = $cacah['nominal']+$saldodb;
						echo "<td align='right'>".format_rp($cacah['nominal'])."</td>";
						echo "<td>-</td>";	
					}else{
                        $saldokr = $cacah['nominal']+$saldokr;
						echo "<td>-</td>";	
						echo "<td align='right'>".format_rp($cacah['nominal'])."</td>";
					}
				echo "</tr>";	
		endforeach;			
	 
	 ?>
     <tr>
        <td colspan=4>Total</td>
        <td align='right'><b><?= format_rp($saldodb) ?></b></td>
        <td align='right'><b><?= format_rp($saldokr) ?></b></td>
     </tr>
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