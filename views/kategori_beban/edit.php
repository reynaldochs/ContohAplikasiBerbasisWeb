<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
  <!-- Content Header (Page header) -->
  <section class="content-header">
      <h1>
          Kategori Beban
          <small>Edit Data</small>
      </h1>
  </section>

  <!-- Main content -->
  <section class="content">
        <div class="row">
            <!-- left column -->
                <div class="col-md-12">
                    <!-- general form elements -->
                    <div class="box box-danger">
                        <div class="box-header with-border">
                            <a href="<?= site_url('kategoribeban') ?>" class="btn btn-success"><i class="fa fa-chevron-left"></i> Kembali</a>
                        </div>
                    <!-- /.box-header -->
                    <!-- form start -->
                        <form role="form" method="POST" action="<?= site_url('kategoribeban/update/'.$kategoriBeban->id)?>">
                            <div class="box-body">
                                <div class="form-group">
                                    <label>Kode Kategori Beban</label>
                                    <input type="text" class="form-control" placeholder="Kode Kategori Beban" value="<?= $kategoriBeban->id ?>" readonly>
                                </div>
                                <div class="form-group">
                                    <label>Nama Kategori Beban</label>
                                    <input type="text" class="form-control" name="nama_kategori" placeholder="Nama Kategori Beban" required value="<?= $kategoriBeban->nama_kategori ?>">
                                </div>
                            </div>
                            <div class="form-group">
                                    <label>Nama Akun Beban</label>
                                    <select class="form-control" name="kode_akun">
                                        <option>[ Pilih Akun ]</option>
                                        <?php
                                        foreach($dataAkun as $akun) { ?>
                                                <option value="<?= $akun->kode_akun ?>" <?= $kategoriBeban->no_akun == $akun->kode_akun?"selected":"" ?>><?= $akun->kode_akun ?> - <?= $akun->nama_akun ?></option>
                                            <?php
                                        
                                        }
                                    ?>
                                    </select>
                                </div>
                        <!-- /.box-body -->
                        <div class="box-footer">
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div>
                    </form>
                </div>
            <!-- /.box -->
            </div>
            <!--/.col (left) -->
        </div>
    <!-- /.row -->
  </section>
  <!-- /.content -->
</div>
  <!-- /.content-wrapper -->