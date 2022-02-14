<?php

	function format_rp($a){
		if(!is_numeric($a))return NULL;
		$jumlah_desimal ="2";
		$pemisah_desimal =",";
		$pemisah_ribuan =".";
		$angka = "Rp. ". number_format($a, $jumlah_desimal, $pemisah_desimal, $pemisah_ribuan);
		return $angka;
	}
	
	function arr_size($index=null)
	{
		$size = ['AllSize','XS','S','FitS','M','FitM','L','FitL','XL','XXL','FitXL','FitXXL'];
		if($index !== null) return $size[$index];
		return $size;
	}
?>