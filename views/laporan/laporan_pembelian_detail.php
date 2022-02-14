<style>
    .table, table, tr, th, td {
        white-space: nowrap;
        table-layout: auto !important;
    }

</style>
<table class="table table-bordered table-striped">
    <thead>
        <tr>
            <th>No</th>
            <th>Kode Pembelian</th>
            <th>Tanggal Pembelian</th>
            <th>Kode Bahan Baku</th>
            <th>Bahan Baku</th>
            <th>Satuan</th>
            <th>Harga Satuan</th>
            <th>Jumlah Pembelian</th>
            <th>Sub Total</th>
        </tr>
    </thead>
    <tbody>
        <?php
            $totalPembelian = 0;
            foreach($detail as $index => $result) {
                $totalPembelian += $result->sub_total;
                ?>
                    <tr>
                        <td><?= $index + 1; ?></td>
                        <td><?= $result->pembelian_id; ?></td>
                        <td><?= $result->tanggal_transaksi; ?></td>
                        <td><?= $result->bahan_baku_id; ?></td>
                        <td><?= $result->nama_bahan_baku; ?></td>
                        <td><?= $result->satuan; ?></td>
                        <td align="right"><?= "Rp. ".number_format($result->harga_satuan, 0, ",", "."); ?></td>
                        <td align="right"><?= $result->jumlah_pembelian; ?></td>
                        <td align="right"><?= "Rp. ".number_format($result->sub_total, 0, ",", ".") ?></td>
                    </tr>
                <?php
            }
        ?>
        <tr>    
            <td colspan="8" align="center">Total</td>
            <td align="right"><?= "Rp. ".number_format($totalPembelian, 0, ",", ".") ?></td>
        </tr>
    </tbody>
</table>