<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Buku Besar
            <small>data</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box"><br>
                <div class="col-xs-12">
                    <form class='form-inline' method="POST" class="form-inline"
                            action="<?php echo site_url().'keuangan/buku_besar';?>">
                            
                            <div class="form-group">
                                <label>Pilih Akun</label> 
                                <select name="kode_akun" class="form-control input-sm">
                                    <option value="#" disabled selected>Pilih Akun</option>
                                    <?php foreach($akun as $data){
                                        echo "
                                            <option ".($data['kode_akun'] == $selected_akun ? 'selected' : '')." value = ".$data['kode_akun'].">".$data['nama_akun']."</option>
                                            ";
                                        }
                                        ?>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Bulan</label> 
                                <select name="bulan" class="form-control">
                                    <option value="" disabled selected>Pilih Bulan</option>
                                    <option value="1">Jan</option>
                                    <option value="2">Feb</option>
                                    <option value="3">Mar</option>
                                    <option value="4">Apr</option>
                                    <option value="5">Mei</option>
                                    <option value="6">Jun</option>
                                    <option value="7">Jul</option>
                                    <option value="8">Agt</option>
                                    <option value="9">Sept</option>
                                    <option value="10">Okt</option>
                                    <option value="11">Nov</option>
                                    <option value="12">Des</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Tahun</label>
                                <select name="tahun" class="form-control">
                                    <option value="" disabled selected>Pilih Tahun</option> <?php for ($i=2017; $i < 2025; $i++) {
                                        echo "<option value". $i.">".$i."</option>"; } ?>
                                </select>
                            </div>
                            <button class="btn btn-info btn-sm" type="submit" name="submit">Submit</button>
                        </form>
                </div><hr>
                <div class="box-header">
                    <center>
                        <h3>Bandung Clothing Corporatian</h3>
                        <h3>Buku Besar</h3>
                        <h3>Periode <?= date('M-Y',strtotime($tanggal)) ?></h3>
                    </center>
                    </div>  
                    <!-- /.box-header -->
                    <div class="box-body">
                    <?php
	                    if (isset($_POST['submit'])) {
                            $kode = 0;
                            $nama="";
                            foreach($buku_besar as $cacah){
                                $nama = $cacah['nama_akun'];
                                $kode = $cacah['kode_akun'];
                        }?>
                    <table>
                        <tr class="table">
                            <th>No Akun : <?=$kode?></th>
                            <th>&nbsp;</th><th>&nbsp;</th><th>&nbsp;</th><th>&nbsp;</th>
                            <th>&nbsp;</th><th>&nbsp;</th><th>&nbsp;</th><th>&nbsp;</th>
                            <th>&nbsp;</th><th>&nbsp;</th><th>&nbsp;</th><th>&nbsp;</th>
                            <th>&nbsp;</th><th>&nbsp;</th><th>&nbsp;</th><th>&nbsp;</th>
                            <th>&nbsp;</th><th>&nbsp;</th><th>&nbsp;</th><th>&nbsp;</th>   	
                            <th>Nama Akun : <?=$nama?></th>
                        </tr>
                    </table>
                    <?php } ?>
                        <table class = 'table table-bordered'>
                            <thead>
                                <tr align="center">
                                    <th rowspan=2>Tanggal</th>
                                    <th rowspan=2>Keterangan</th>
                                    <th rowspan=2>Reff</th>
                                    <th rowspan=2>Debit</th>
                                    <th rowspan=2>Kredit</th>
                                    <th colspan=2>Saldo</th>
                                </tr>
                                <tr align="center">
                                    <th>Debit</th>
                                    <th>Kredit</th>
                                </tr>
                            </thead>
                            <?php 
                                $saldo_awal = $saldo_awal; $val_saldo_awal = 0;
                                $val_saldo_awal = $saldo_awal->tot_dr - $saldo_awal->tot_cr;
                            ?>
                            <tbody>
                                <tr>
                                    <th></th>
                                    <th>Saldo Awal</th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th style="text-align:right;"><?=$val_saldo_awal >= 0 ? format_rp(abs($val_saldo_awal)) : '' ?></th>
                                    <th style="text-align:right;"><?=$val_saldo_awal < 0 ? format_rp(abs($val_saldo_awal)) : ''?></th>
                                </tr>
                                <?php
                                $total_debit = 0;
                                $total_kredit = 0;
                                $ctr_tgl = "";
                                $spasi = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
                                foreach($jurnal as $bb):?>
                                    <tr>
                                        <td align="center"><?=date('d-m-Y',strtotime($bb['tgl_transaksi']))?></td>
                                        <td><?=$bb['nama_akun']?></td>
                                        <td><?=$bb['kode_akun']?></td>
                                        <?php
                                            if($bb['posisi_dr_cr'] == 'debet'):
                                                $val_saldo_awal += $bb['nominal'];
                                                $total_debit += $bb['nominal'];
                                            else:
                                                $total_kredit += $bb['nominal'];
                                                $val_saldo_awal -= $bb['nominal'];
                                            endif;
                                        ?>
                                        <td style="text-align:right;"><?=$bb['posisi_dr_cr'] == 'debet' ? format_rp(abs($bb['nominal'])) : '' ?></td>
                                        <td style="text-align:right;"><?=$bb['posisi_dr_cr'] == 'kredit' ? format_rp(abs($bb['nominal'])) : ''?></td>
                                        <td style="text-align:right;"><?=$val_saldo_awal >= 0 ? format_rp(abs($val_saldo_awal)) : '' ?></td>
                                        <td style="text-align:right;"><?=$val_saldo_awal < 0 ? format_rp(abs($val_saldo_awal)) : ''?></td>
                                    </tr>
                                <?php endforeach;?>
                                <tr>
                                    <th></th>
                                    <th>Saldo Akhir</th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th style="text-align:right;"><?=$val_saldo_awal >= 0 ? format_rp(abs($val_saldo_awal)) : '' ?></th>
                                    <th style="text-align:right;"><?=$val_saldo_awal < 0 ? format_rp(abs($val_saldo_awal)) : ''?></th>
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