delimiter $$
CREATE TRIGGER `input_pembayaran2` AFTER INSERT ON `pesanan`
 FOR EACH ROW BEGIN
SET @jum_pesanan = (SELECT COUNT(*) FROM pesanan WHERE pelanggan_id = NEW.pelanggan_id);
SET @struk = ("TK"+(RAND()*100)+NEW.id);
INSERT INTO pembayaran VALUES (null,@struk ,NEW.tanggal,0,@jum_pesanan,NEW.id,"belum lunas");
END$$
delimiter ;

delimiter $$
CREATE TRIGGER `check_status` BEFORE UPDATE ON `pembayaran`
 FOR EACH ROW BEGIN
SET @total = (SELECT total FROM pesanan WHERE id = NEW.pesanan_id);
IF NEW.jumlah > @total THEN
SET NEW.status_pembayaran = "lunas";
ELSE
SET NEW.status_pembayaran = "belum lunas";
END IF;
END$$
delimiter ;