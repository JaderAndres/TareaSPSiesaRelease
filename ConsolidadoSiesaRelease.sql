USE SiesaRelease;
--- PROCEDIMIENTOS ALMACENADOS DE SIESA RELEASE ---
USE UnoEE_Pruebas;
--IF EXISTS (SELECT *
--           FROM   sys.views
--           WHERE  object_id = Object_id(N'BI_T120'))
--  DROP VIEW BI_T120

--GO

--CREATE VIEW BI_T120
--  AS
  SELECT f120_id_cia,
         f120_id,
         f121_rowid,
         f120_referencia,
         f120_descripcion,
         f120_descripcion_corta,
         f121_fecha_creacion                                         fecha_creacion,
         CASE f121_ind_estado
           WHEN 0 THEN 'Inactivo'
           WHEN 1 THEN 'Activo'
           WHEN 2 THEN 'Bloqueado'
         END                                                         estado,
         CASE f120_ind_tipo_item
           WHEN 1 THEN 'Inventario'
           WHEN 2 THEN 'Servicio'
           WHEN 3 THEN 'Kits'
           WHEN 4 THEN 'Fantasma'
         END                                                         f120_tipo_item,
         CASE
           WHEN f120_ind_compra = 1 THEN 'Si'
           ELSE 'No'
         END                                                         f120_item_para_compra,
         CASE
           WHEN f120_ind_venta = 1 THEN 'Si'
           ELSE 'No'
         END                                                         f120_item_para_venta,
         CASE
           WHEN f120_ind_manufactura = 1 THEN 'Si'
           ELSE 'No'
         END                                                         f120_item_para_manufactura,
         CASE
           WHEN f120_ind_lote <> 0 THEN 'Si'
           ELSE 'No'
         END                                                         f120_maneja_lote,
         CASE
           WHEN f120_ind_serial <> 0 THEN 'Si'
           ELSE 'No'
         END                                                         f120_maneja_serial,
         f120_id_unidad_inventario,
         f120_id_unidad_adicional,
         f120_id_unidad_orden,
         f120_id_unidad_empaque,
         f120_id_extension1,
         f121_id_ext1_detalle,
         f117_descripcion,
         f120_id_extension2,
         f119_descripcion,
         f121_id_ext2_detalle,
         t122_inv.f122_peso                                          peso,
         t122_inv.f122_volumen                                       volumen,
         t122_adic.f122_factor                                       fact_adic,
         t122_ord.f122_factor                                        fact_ord,
         t122_emp.f122_factor                                        fact_emp,
         t125.id_cri_mayor_item_1                                    id_cri_mayor_item_1,
         t125.desc_cri_mayor_item_1                                  desc_cri_mayor_item_1,
         t125.id_cri_mayor_item_2                                    id_cri_mayor_item_2,
         t125.desc_cri_mayor_item_2                                  desc_cri_mayor_item_2,
         t125.id_cri_mayor_item_3                                    id_cri_mayor_item_3,
         t125.desc_cri_mayor_item_3                                  desc_cri_mayor_item_3,
         t125.id_cri_mayor_item_4                                    id_cri_mayor_item_4,
         t125.desc_cri_mayor_item_4                                  desc_cri_mayor_item_4,
         t125.id_cri_mayor_item_5                                    id_cri_mayor_item_5,
         t125.desc_cri_mayor_item_5                                  desc_cri_mayor_item_5,
         t125.id_cri_mayor_item_6                                    id_cri_mayor_item_6,
         t125.desc_cri_mayor_item_6                                  desc_cri_mayor_item_6,
         t125.id_cri_mayor_item_7                                    id_cri_mayor_item_7,
         t125.desc_cri_mayor_item_7                                  desc_cri_mayor_item_7,
         t125.id_cri_mayor_item_8                                    id_cri_mayor_item_8,
         t125.desc_cri_mayor_item_8                                  desc_cri_mayor_item_8,
         t125.id_cri_mayor_item_9                                    id_cri_mayor_item_9,
         t125.desc_cri_mayor_item_9                                  desc_cri_mayor_item_9,
         t125.id_cri_mayor_item_10                                   id_cri_mayor_item_10,
         t125.desc_cri_mayor_item_10                                 desc_cri_mayor_item_10,
         f120_notas,
         f121_id_barras_principal                                    cod_barra_principal,
         dbo.F_generico_hallar_ult_ref_alt (f120_id_cia, f120_rowid) f_ref_alterna,
		 t125.parametro_biable                               parametro_biable
  FROM   t120_mc_items t120
         LEFT JOIN t121_mc_items_extensiones
                ON t120.f120_rowid = f121_rowid_item
         LEFT JOIN t117_mc_extensiones1_detalle
                ON f117_id_cia = f121_id_cia
                   AND f121_id_extension1 = f117_id_extension1
                   AND f121_id_ext1_detalle = f117_id
         LEFT JOIN t119_mc_extensiones2_detalle
                ON f119_id_cia = f121_id_cia
                   AND f121_id_extension2 = f119_id_extension2
                   AND f121_id_ext2_detalle = f119_id
         LEFT JOIN t122_mc_items_unidades t122_inv
                ON t120.f120_rowid = t122_inv.f122_rowid_item
                   AND t120.f120_id_cia = t122_inv.f122_id_cia
                   AND t120.f120_id_unidad_inventario = t122_inv.f122_id_unidad
         LEFT JOIN t122_mc_items_unidades t122_adic
                ON t120.f120_rowid = t122_adic.f122_rowid_item
                   AND t120.f120_id_cia = t122_adic.f122_id_cia
                   AND t120.f120_id_unidad_adicional = t122_adic.f122_id_unidad
         LEFT JOIN t122_mc_items_unidades t122_ord
                ON t120.f120_rowid = t122_ord.f122_rowid_item
                   AND t120.f120_id_cia = t122_ord.f122_id_cia
                   AND t120.f120_id_unidad_orden = t122_ord.f122_id_unidad
         LEFT JOIN t122_mc_items_unidades t122_emp
                ON t120.f120_rowid = t122_emp.f122_rowid_item
                   AND t120.f120_id_cia = t122_emp.f122_id_cia
                   AND t120. f120_id_unidad_empaque = t122_emp.f122_id_unidad
         INNER JOIN BI_T125 t125
                 ON T125.rowid_item_ext = f121_rowid
         

GO


******************************
--1.17.131 --1.17.331 --1.17.531 --1.17.731 --1.17.929 --1.17.1130 --1.18.131 --1.18.328 

--OPTIMIZADO NICOLAS

IF EXISTS (SELECT *
           FROM   sys.views
           WHERE  object_id = Object_id(N'BI_T470'))
  DROP VIEW BI_T470

GO

CREATE VIEW BI_T470
AS
  SELECT /*MOVIMIENTO DE INVENTARIO*/ t470_inv.f470_id_cia                             f_cia,
                                      t150.f150_id                                     f_bodega,
                                      t470_inv.f470_id_instalacion                     f_instalacion,
                                      Isnull(t470_inv.f470_id_lote, ' ')               f_lote,
                                      t470_inv.f470_rowid_item_ext                     f_rowid_item_lote,
                                      f285_id                                          f_id_co,
                                      Isnull(t470_inv.f470_id_ubicacion_aux, ' ')      f_ubicacion,
                                      t003.f003_descripcion                            f_modulo_desc,
                                      t470_inv.f470_id_concepto                        f_cpto,
                                      f145_descripcion                                 f_desc_cpto,
                                      t470_inv.f470_id_motivo                          f_motivo,
                                      f146_descripcion                                 f_desc_motivo,
                                      Isnull(t470_inv.f470_id_un_movto, ' ')           f_un,
                                      Isnull(f284_id, ' ')                             f_ccosto,
                                      Isnull(t470_inv.f470_id_proyecto, ' ')           f_proyecto,
                                      f107_descripcion                                 f_desc_proyecto,
                                      Isnull(t_terc.f200_id, ' ')                      f_tercero,
                                      t120_item.f120_id_tipo_inv_serv                  f_tipo_inv,
                                      f149_descripcion                                 f_desc_tipo_inv,
                                      t470_inv.f470_id_periodo						   f_periodo,
                                      t470_inv.f470_id_fecha						   f_fecha,
                                      t350_inv.f350_id_tipo_docto                      f_tipo_docto,
                                      t350_inv.f350_consec_docto                       f_docto,
                                      t350_inv.f350_ind_estado                         f_ind_estado,
                                      CASE t350_inv.f350_ind_estado
                                        WHEN 0 THEN 'En elaboración'
                                        WHEN 1 THEN 'Aprobadas'
                                        WHEN 2 THEN 'Anuladas'
                                        WHEN 3 THEN 'Contabilizado'
                                      END                                              f_estado,
                                      t120_item.f120_id                                f_item,
                                      t120_item.f120_rowid                             f_rowid_item,
                                      t121_item.f121_rowid                             f_rowid_item_ext,
                                      t120_item.f120_id_unidad_inventario              f_um,
                                      Isnull(t120_item.f120_id_unidad_adicional, ' ')  f_um_adic,
                                      t120_item.f120_id_grupo_impositivo               f_grupo_impositivo,
                                      t350_inv.f350_referencia                         f_docto_alterno,
                                      t470_inv.f470_notas                              f_notas_movto,
                                      t350_inv.f350_notas                              f_notas_docto,
                                      t_umi.f122_peso                                  f_peso,
                                      CASE
                                        WHEN t120_item.f120_id_unidad_empaque IS NOT NULL THEN t120_item.f120_id_unidad_empaque
                                        ELSE t120_item.f120_id_unidad_inventario
                                      END                                              f_um_emp,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN t470_inv.f470_cant_1
                                            ELSE 0
                                          END)                                         f_cant_ent_1,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 2 THEN t470_inv.f470_cant_1
                                            ELSE 0
                                          END)                                         f_cant_sal_1,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN t470_inv.f470_cant_1
                                            ELSE -( t470_inv.f470_cant_1 )
                                          END)                                         f_cant_net_1,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN t470_inv.f470_cant_2
                                            ELSE 0
                                          END)                                         f_cant_ent_2,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 2 THEN t470_inv.f470_cant_2
                                            ELSE 0
                                          END)                                         f_cant_sal_2,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN t470_inv.f470_cant_2
                                            ELSE -( t470_inv.f470_cant_2 )
                                          END)                                         f_cant_net_2,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN Round(t470_inv.f470_cant_1 / Isnull(t_ume.f122_factor, 1), 4)
                                            ELSE 0
                                          END)                                         f_cant_ent_emp,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 2 THEN Round(t470_inv.f470_cant_1 / Isnull(t_ume.f122_factor, 1), 4)
                                            ELSE 0
                                          END)                                         f_cant_sal_emp,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN Round(t470_inv.f470_cant_1 / Isnull(t_ume.f122_factor, 1), 4)
                                            ELSE -( Round(t470_inv.f470_cant_1 / Isnull(t_ume.f122_factor, 1), 4) )
                                          END)                                         f_cant_net_emp,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN Round(t470_inv.f470_cant_1 * t_umi.f122_peso, 4)
                                            ELSE 0
                                          END)                                         f_cant_ent_peso,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 2 THEN Round(t470_inv.f470_cant_1 * t_umi.f122_peso, 4)
                                            ELSE 0
                                          END)                                         f_cant_sal_peso,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN Round(t470_inv.f470_cant_1 * t_umi.f122_peso, 4)
                                            ELSE -( Round(t470_inv.f470_cant_1 * t_umi.f122_peso, 4) )
                                          END)                                         f_cant_net_peso,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN Round(t470_inv.f470_cant_1 * t_umi.f122_volumen, 4)
                                            ELSE 0
                                          END)                                         f_cant_ent_vol,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 2 THEN Round(t470_inv.f470_cant_1 * t_umi.f122_volumen, 4)
                                            ELSE 0
                                          END)                                         f_cant_sal_vol,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN Round(t470_inv.f470_cant_1 * t_umi.f122_volumen, 4)
                                            ELSE -( Round(t470_inv.f470_cant_1 * t_umi.f122_volumen, 4) )
                                          END)                                         f_cant_net_vol,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN t470_inv.f470_costo_prom_tot
                                            ELSE 0
                                          END)                                         f_costo_prom_ent,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 2 THEN t470_inv.f470_costo_prom_tot
                                            ELSE 0
                                          END)                                         f_costo_prom_sal,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN t470_inv.f470_costo_prom_tot
                                            ELSE -( t470_inv.f470_costo_prom_tot )
                                          END)                                         f_costo_prom_net,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN t470_inv.f470_costo_est_tot
                                            ELSE 0
                                          END)                                         f_costo_est_ent,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 2 THEN t470_inv.f470_costo_est_tot
                                            ELSE 0
                                          END)                                         f_costo_est_sal,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN t470_inv.f470_costo_est_tot
                                            ELSE -( t470_inv.f470_costo_est_tot )
                                          END)                                         f_costo_est_net,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN Isnull(t470_inv.f470_costo_mp_en
                                                               + t470_inv.f470_costo_mp_np, 0)
                                            ELSE 0
                                          END)                                         f_costo_mp_ent,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN Isnull(t470_inv.f470_costo_mp_en, 0)
                                            ELSE 0
                                          END)                                         f_costo_mp_en_ent,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN Isnull(t470_inv.f470_costo_mp_np, 0)
                                            ELSE 0
                                          END)                                         f_costo_mp_np_ent,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN Isnull(t470_inv.f470_costo_mo_en
                                                               + t470_inv.f470_costo_mo_np, 0)
                                            ELSE 0
                                          END)                                         f_costo_mo_ent,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN Isnull(t470_inv.f470_costo_mo_en, 0)
                                            ELSE 0
                                          END)                                         f_costo_mo_en_ent,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN Isnull(t470_inv.f470_costo_mo_np, 0)
                                            ELSE 0
                                          END)                                         f_costo_mo_np_ent,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN Isnull(t470_inv.f470_costo_cif_en
                                                               + t470_inv.f470_costo_cif_np, 0)
                                            ELSE 0
                                          END)                                         f_costo_cif_ent,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN Isnull(t470_inv.f470_costo_cif_en, 0)
                                            ELSE 0
                                          END)                                         f_costo_cif_en_ent,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 1 THEN Isnull(t470_inv.f470_costo_cif_np, 0)
                                            ELSE 0
                                          END)                                         f_costo_cif_np_ent,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 2 THEN Isnull(t470_inv.f470_costo_mp_en
                                                               + t470_inv.f470_costo_mp_np, 0)
                                            ELSE 0
                                          END)                                         f_costo_mp_sal,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 2 THEN Isnull(t470_inv.f470_costo_mp_en, 0)
                                            ELSE 0
                                          END)                                         f_costo_mp_en_sal,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 2 THEN Isnull(t470_inv.f470_costo_mp_np, 0)
                                            ELSE 0
                                          END)                                         f_costo_mp_np_sal,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 2 THEN Isnull(t470_inv.f470_costo_mo_en
                                                               + t470_inv.f470_costo_mo_np, 0)
                                            ELSE 0
                                          END)                                         f_costo_mo_sal,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 2 THEN Isnull(t470_inv.f470_costo_mo_en, 0)
                                            ELSE 0
                                          END)                                         f_costo_mo_en_sal,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 2 THEN Isnull(t470_inv.f470_costo_mo_np, 0)
                                            ELSE 0
                                          END)                                         f_costo_mo_np_sal,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 2 THEN Isnull(t470_inv.f470_costo_cif_en
                                                               + t470_inv.f470_costo_cif_np, 0)
                                            ELSE 0
                                          END)                                         f_costo_cif_sal,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 2 THEN Isnull(t470_inv.f470_costo_cif_en, 0)
                                            ELSE 0
                                          END)                                         f_costo_cif_en_sal,
                                      Sum(CASE t470_inv.f470_ind_naturaleza
                                            WHEN 2 THEN Isnull(t470_inv.f470_costo_cif_np, 0)
                                            ELSE 0
                                          END)                                         f_costo_cif_np_sal,
                                      Isnull(t470_inv.f470_rowid_movto_proceso_ent, 0) f_rowid_movto_proceso_ent,
                                      f400_cant_nivel_min_1                            f_nivel_minimo,
                                      f400_cant_nivel_max_1                            f_nivel_maximo,
                                      f680_id                                          f_parametro_biable,
                                      Isnull(t120_sobre.f120_id, 0)                    f_cod_item_sobrecosto,
                                      Isnull(t120_sobre.f120_rowid, 0)                 f_rowid_item_sobrecosto,
                                      Isnull(t121_sobre.f121_rowid, 0)                 f_rowid_item_ext_sobrecosto,
                                      Isnull(t350_sobre.f350_id_tipo_docto, '')        f_tipo_docto_sobrecosto,
                                      Isnull(t350_sobre.f350_consec_docto, 0)          f_nro_docto_base_sobrecosto,
                                      CASE t470_inv.f470_ind_naturaleza
                                        WHEN 1 THEN Isnull(sal.f150_id, '')
                                        ELSE Isnull(ent.f150_id, '')
                                      END                                              f_id_bodega_orig_dest,
                                      CASE t470_inv.f470_ind_naturaleza
                                        WHEN 1 THEN Isnull(sal.f150_descripcion, '')
                                        ELSE Isnull(ent.f150_descripcion, '')
                                      END                                              f_desc_bodega_orig_dest,
                                      CASE
                                        WHEN f440_consec_docto <> 0 THEN f440_id_co + '-' + f440_id_tipo_docto + '-'
                                                                         + dbo.Lpad(f440_consec_docto, 8, '0')
                                        ELSE ' '
                                      END                                              f_docto_requisicion
  FROM   t470_cm_movto_invent t470_inv --WITH(INDEX(ix_t470_20))
         INNER JOIN t150_mc_bodegas t150
                 ON t150.f150_rowid = t470_inv.f470_rowid_bodega
         INNER JOIN t145_mc_conceptos t145
                 ON t145.f145_id = t470_inv.f470_id_concepto
         INNER JOIN t146_mc_motivos
                 ON f146_id_cia = t470_inv.f470_id_cia
                    AND f146_id_concepto = t470_inv.f470_id_concepto
                    AND f146_id = t470_inv.f470_id_motivo
         INNER JOIN t003_pp_modulos t003
                 ON t003.f003_id = t145.f145_id_modulo
         INNER JOIN t350_co_docto_contable t350_inv
                 ON t350_inv.f350_rowid = t470_inv.f470_rowid_docto
         INNER JOIN t121_mc_items_extensiones t121_item
                 ON t121_item.f121_rowid = t470_inv.f470_rowid_item_ext
         INNER JOIN t120_mc_items t120_item
                 ON t120_item.f120_rowid = t121_item.f121_rowid_item
         LEFT JOIN t441_movto_req_int
                ON f441_rowid = t470_inv.f470_rowid_movto_req_int
         LEFT JOIN t440_docto_req_int
                ON f440_rowid = f441_rowid_docto_req_int
         INNER JOIN t122_mc_items_unidades t_umi
                 ON t_umi.f122_rowid_item = f120_rowid
                    AND t_umi.f122_id_unidad = f120_id_unidad_inventario
                    AND t_umi.f122_id_cia = f120_id_cia
         INNER JOIN t680_in_biable t680
                 ON ( t680.f680_ind_filtrar_cia = 0
                       OR ( t680.f680_ind_filtrar_cia = 1
                            AND t680.f680_id_cia = t470_inv.f470_id_cia ) )
         LEFT JOIN t400_cm_existencia
                ON f400_id_cia = t470_inv.f470_id_cia
                   AND f400_rowid_item_ext = t470_inv.f470_rowid_item_ext
                   AND f400_rowid_bodega = t470_inv.f470_rowid_bodega
         LEFT JOIN t200_mm_terceros t_terc
                ON t_terc.f200_rowid = t350_inv.f350_rowid_tercero
         LEFT JOIN t284_co_ccosto
                ON f284_rowid = t470_inv.f470_rowid_ccosto_movto
         LEFT JOIN t285_co_centro_op
                ON f285_id = t470_inv.f470_id_co_movto
                   AND f285_id_cia = t470_inv.f470_id_cia
         LEFT JOIN t122_mc_items_unidades t_ume
                ON t_ume.f122_rowid_item = f120_rowid
                   AND t_ume.f122_id_unidad = f120_id_unidad_empaque
                   AND t_ume.f122_id_cia = f120_id_cia
         LEFT JOIN t107_mc_proyectos
                ON f107_id_cia = t470_inv.f470_id_cia
                   AND f107_id = t470_inv.f470_id_proyecto
         LEFT JOIN t121_mc_items_extensiones t121_sobre
                ON t121_sobre.f121_rowid = t470_inv.f470_rowid_item_ext_imp_compra
                   AND t470_inv.f470_rowid_item_ext_imp_compra <> t470_inv.f470_rowid_item_ext
         LEFT JOIN t120_mc_items t120_sobre
                ON t120_sobre.f120_rowid = t121_sobre.f121_rowid_item
         LEFT JOIN t470_cm_movto_invent t470_sobrecosto
                ON t470_sobrecosto.f470_rowid = t470_inv.f470_rowid_mov_inv_imp_compra
         LEFT JOIN t350_co_docto_contable t350_sobre
                ON t350_sobre.f350_rowid = t470_sobrecosto.f470_rowid_docto
         LEFT JOIN t450_cm_docto_invent
                ON f450_rowid_docto = t350_inv.f350_rowid
         LEFT JOIN t150_mc_bodegas sal
                ON f450_rowid_bodega_salida = sal.f150_rowid
         LEFT JOIN t150_mc_bodegas ent
                ON f450_rowid_bodega_entrada = ent.f150_rowid
         LEFT JOIN t149_mc_tipo_inv_serv
                ON t120_item.f120_id_tipo_inv_serv = f149_id
                   AND t120_item.f120_id_cia = f149_id_cia
  WHERE  t470_inv.f470_ind_estado_cm <> 2
  GROUP  BY t470_inv.f470_id_cia,
            t150.f150_id,
            t470_inv.f470_id_instalacion,
            Isnull(t470_inv.f470_id_lote, ' '),
            t470_inv.f470_rowid_item_ext,
            f285_id,
            Isnull(t470_inv.f470_id_ubicacion_aux, ' '),
            t003.f003_descripcion,
            t470_inv.f470_id_concepto,
            f145_descripcion,
            t470_inv.f470_id_motivo,
            f146_descripcion,
            t470_inv.f470_id_un_movto,
            Isnull(f284_id, ' '),
            t470_inv.f470_id_proyecto,
            f107_descripcion,
            Isnull(t_terc.f200_id, ' '),
            t120_item.f120_id_tipo_inv_serv,
            f149_descripcion,
            t470_inv.f470_id_fecha,
            t350_inv.f350_id_tipo_docto,
            t350_inv.f350_id_tipo_docto,
            t350_inv.f350_consec_docto,
            t350_inv.f350_ind_estado,
            t120_item.f120_id,
            t120_item.f120_rowid,
            t121_item.f121_rowid,
            t120_item.f120_id_unidad_inventario,
            t120_item.f120_id_unidad_adicional,
            CASE
              WHEN t120_item.f120_id_unidad_empaque IS NOT NULL THEN t120_item.f120_id_unidad_empaque
              ELSE t120_item.f120_id_unidad_inventario
            END,
            t120_item.f120_id_grupo_impositivo,
            t350_inv.f350_referencia,
            t470_inv.f470_notas,
            t350_inv.f350_notas,
            t_umi.f122_peso,
            Isnull(t470_inv.f470_rowid_movto_proceso_ent, 0),
            f400_cant_nivel_min_1,
            f400_cant_nivel_max_1,
            f680_id,
            Isnull(t120_sobre.f120_id, 0),
            Isnull(t120_sobre.f120_rowid, 0),
            Isnull(t121_sobre.f121_rowid, 0),
            Isnull(t350_sobre.f350_id_tipo_docto, ''),
            Isnull(t350_sobre.f350_consec_docto, 0),
            CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN Isnull(sal.f150_id, '')
              ELSE Isnull(ent.f150_id, '')
            END,
            CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN Isnull(sal.f150_descripcion, '')
              ELSE Isnull(ent.f150_descripcion, '')
            END,
            CASE
              WHEN f440_consec_docto <> 0 THEN f440_id_co + '-' + f440_id_tipo_docto + '-'
                                               + dbo.Lpad(f440_consec_docto, 8, '0')
              ELSE ' '
            END,
			t470_inv.f470_id_periodo

GO 

******************************

IF EXISTS (SELECT *
           FROM   sys.views
           WHERE  object_id = Object_id(N'BI_T451_1'))
  DROP VIEW BI_T451_1

GO
 
CREATE VIEW [dbo].[BI_T451_1]
AS
  SELECT /*MOVIMIENTO DE COMPRA*/ t350_t1.f350_id_cia                                                        f_id_cia,
                                  t350_t1.f350_id_co                                                         f_co_docto,
                                  t350_t1.f350_id_tipo_docto                                                 f_id_tipo_docto,
                                  t350_t1.f350_consec_docto                                                  f_docto,
                                  CONVERT(VARCHAR(6), t470_comp.f470_id_fecha, 112)                          f_periodo,
                                  CONVERT(CHAR(8), t470_comp.f470_id_fecha, 112)                             f_fecha,
                                  estado_co.f054_descripcion                                                 f_estado,
                                  tproveedor.f200_id                                                         f_proveedor,
                                  f451_id_sucursal_prov                                                      f_prov_suc,
                                  tcomprador.f200_id                                                         f_comprador,
                                  tcomprador.f200_razon_social                                               f_comprador_desc,
                                  CASE                                                                        
                                    WHEN Isnull(t420_sc_docto.f420_rowid, 0) = 0 THEN ''                      
                                    ELSE Rtrim(t420_sc_docto.f420_id_co) + '-'
                                         + Rtrim(t420_sc_docto.f420_id_tipo_docto)
                                         + '-'
                                         + dbo.Lpad(t420_sc_docto.f420_consec_docto, 8, '0')
                                  END                                                                        f_nro_sc,
                                  CASE
                                    WHEN Isnull(t420_oc_docto.f420_rowid, 0) = 0 THEN ''
                                    ELSE Isnull(Rtrim(t420_oc_docto.f420_id_tipo_docto)
                                                + '-'
                                                + dbo.Lpad(t420_oc_docto.f420_consec_docto, 8, '0'), '')
                                  END                                                                        f_nro_oc,
                                  CASE
                                    WHEN Isnull(t350_t2.f350_rowid, 0) = 0 THEN ''
                                    ELSE Isnull(t350_t2.f350_id_tipo_docto + '-'
                                                + dbo.Lpad(t350_t2.f350_consec_docto, 8, '0'), '')
                                  END                                                                        f_nro_causacion,
                                  f010_id_moneda_local                                                       f_moneda_local,
                                  CASE
                                    WHEN f010_id_moneda_local <> f451_id_moneda_docto THEN f451_id_moneda_docto
                                    ELSE ''
                                  END                                                                        f_moneda_alt,
                                  item_inv.v121_id_item                                                      f_item,
                                  item_inv.v121_rowid_item                                                   f_rowid_item,
                                  item_inv.v121_rowid_item_ext                                               f_rowid_item_ext,
                                  item_inv.v121_id_tipo_inv_serv                                             f_tipo_inv,
                                  f150_id                                                                    f_bodega,
                                  t470_comp.f470_id_instalacion                                              f_instalacion,
                                  t470_comp.f470_id_concepto                                                 f_cpto,
                                  f145_descripcion                                                           f_desc_cpto,
                                  t470_comp.f470_id_motivo                                                   f_motivo,
                                  f146_descripcion                                                           f_desc_motivo,
                                  item_inv.v121_id_grupo_impositivo                                          f_grupo_impositivo,
                                  Isnull(t470_comp.f470_id_proyecto, '')                                     f_proyecto,
                                  f107_descripcion                                                           f_desc_proyecto,
                                  t470_comp.f470_id_unidad_medida                                            f_um_base,
                                  Isnull(item_inv.v121_id_unidad_adicional, '')                              f_um_adic,
                                  item_inv.v121_id_unidad_inventario                                         f_um_inv,
                                  Isnull(t470_comp.f470_id_un_movto, '')                                     f_un,
                                  Isnull(f284_id, '')                                                        f_ccosto,
                                  Isnull(t470_comp.f470_id_co_movto, '')                                     f_co_movto,
                                  t470_comp.f470_notas                                                       f_notas_movto,
                                  CASE
                                    WHEN t470_comp.f470_ind_naturaleza = 2 THEN -t470_comp.f470_cant_base
                                    ELSE t470_comp.f470_cant_base
                                  END                                                                        f_cant_base,
                                  CASE
                                    WHEN t470_comp.f470_ind_naturaleza = 2 THEN -t470_comp.f470_cant_2
                                    ELSE t470_comp.f470_cant_2
                                  END                                                                        f_cant_2,
                                  CASE
                                    WHEN t470_comp.f470_ind_naturaleza = 2 THEN -t470_comp.f470_cant_1
                                    ELSE t470_comp.f470_cant_1
                                  END                                                                        f_cant_1,
                                  CASE
                                    WHEN f010_id_moneda_local <> f451_id_moneda_docto
                                         AND t470_comp.f470_cant_base <> 0 THEN t470_comp.f470_vlr_bruto / t470_comp.f470_cant_base
                                    ELSE
                                      CASE
                                        WHEN f010_id_moneda_local <> f451_id_moneda_docto
                                             AND t470_comp.f470_cant_base = 0 THEN t470_comp.f470_vlr_bruto
                                        ELSE t470_comp.f470_precio_uni
                                      END
                                  END                                                                        f_precio_unit_local,
                                  CASE
                                    WHEN t470_comp.f470_ind_naturaleza = 2 THEN -t470_comp.f470_vlr_bruto
                                    ELSE t470_comp.f470_vlr_bruto
                                  END                                                                        f_valor_bruto_local,
                                  CASE
                                    WHEN t470_comp.f470_ind_naturaleza = 2 THEN -( t470_comp.f470_vlr_dscto_linea
                                                                                   + t470_comp.f470_vlr_dscto_global )
                                    ELSE t470_comp.f470_vlr_dscto_linea
                                         + t470_comp.f470_vlr_dscto_global
                                  END                                                                        f_valor_dscto_local,
                                  CASE
                                    WHEN t470_comp.f470_ind_naturaleza = 2 THEN -t470_comp.f470_vlr_imp
                                    ELSE t470_comp.f470_vlr_imp
                                  END                                                                        f_valor_imp_local,
                                  CASE
                                    WHEN t470_comp.f470_ind_naturaleza = 2 THEN -t470_comp.f470_vlr_neto
                                    ELSE t470_comp.f470_vlr_neto
                                  END                                                                        f_valor_neto_local,
                                  CASE
                                    WHEN t470_comp.f470_ind_naturaleza = 2 THEN -t470_comp.f470_vlr_bruto_alt
                                    ELSE t470_comp.f470_vlr_bruto_alt
                                  END                                                                        f_valor_bruto_alt,
                                  CASE
                                    WHEN t470_comp.f470_ind_naturaleza = 2 THEN -( t470_comp.f470_vlr_dscto_linea_alt
                                                                                   + t470_comp.f470_vlr_dscto_global_alt )
                                    ELSE t470_comp.f470_vlr_dscto_linea_alt
                                         + t470_comp.f470_vlr_dscto_global_alt
                                  END                                                                        f_valor_dscto_alt,
                                  CASE
                                    WHEN t470_comp.f470_ind_naturaleza = 2 THEN -t470_comp.f470_vlr_imp_alt
                                    ELSE t470_comp.f470_vlr_imp_alt
                                  END                                                                        f_valor_imp_alt,
                                  CASE
                                    WHEN t470_comp.f470_ind_naturaleza = 2 THEN -t470_comp.f470_vlr_neto_alt
                                    ELSE t470_comp.f470_vlr_neto_alt
                                  END                                                                        f_valor_neto_alt,
                                  CASE
                                    WHEN t470_comp.f470_ind_naturaleza = 2 THEN -( t470_comp.f470_vlr_bruto - ( t470_comp.f470_vlr_dscto_linea
                                                                                                                + t470_comp.f470_vlr_dscto_global ) )
                                    ELSE t470_comp.f470_vlr_bruto - ( t470_comp.f470_vlr_dscto_linea
                                                                      + t470_comp.f470_vlr_dscto_global )
                                  END                                                                        f_valor_subtotal_local,
                                  CASE t470_comp.f470_ind_naturaleza
                                    WHEN 2 THEN -( t470_comp.f470_cant_base * f122_peso )
                                    ELSE t470_comp.f470_cant_base * f122_peso
                                  END                                                                        f_peso,
                                  CASE t470_comp.f470_ind_naturaleza
                                    WHEN 2 THEN -( t470_comp.f470_cant_base * f122_volumen )
                                    ELSE t470_comp.f470_cant_base * f122_volumen
                                  END                                                                        f_vol,
                                  f451_id_clase_docto                                                        f_id_clase_docto,
                                  t350_t1.f350_consec_docto                                                  f_consec_docto,
                                  t470_comp.f470_rowid                                                       f_rowid,
                                  t470_comp.f470_rowid_docto                                                 f_rowid_docto,
                                  f680_id                                                                    f_parametro_biable,
                                  CASE
                                    WHEN Isnull(f451_rowid_docto_factura, 0) = 0 THEN ''
                                    ELSE Isnull(f455_prefijo_docto_prov + '-'
                                                + dbo.Lpad(f455_numero_docto_prov, 8, '0'), '')
                                  END                                                                        f_nro_fact_prov,
                                  CONVERT(CHAR(8), dbo.F_to_only_date(f455_fecha_docto_prov), 112)           f_fecha_fact_prov,
                                  t120_sobre.f120_id                                                         f_item_sobrecosto,
                                  c126.f126_precio                                                           f_precio,
                                  c126.f126_precio_minimo                                                    f_precio_minimo,
                                  c126.f126_precio_maximo                                                    f_precio_maximo,
                                  Isnull(CONVERT(CHAR(8), t420_oc_docto.f420_fecha_ts_aprobacion, 112), ' ') f_fecha_aprobacion_oc,
                                  Isnull(CONVERT(CHAR(8), t420_sc_docto.f420_fecha_ts_aprobacion, 112), ' ') f_fecha_aprobacion_sc,
                                  f455_prefijo_docto_prov                                                    f_prefijo_docto_prov,
                                  f455_numero_docto_prov                                                     f_numero_docto_prov,
                                  CASE
                                    WHEN f633_ind_tipo_pago = 1 THEN 'Consignacion electronica'
                                    WHEN f633_ind_tipo_pago = 2 THEN 'Cheque gerencia'
                                  END                                                                        f_int_tipo_pago,
                                  Rtrim(Isnull(f633_id_banco, '')) + ' '
                                  + Ltrim(Isnull(f016_descripcion, ''))                                      f_banco,
                                  f633_numero_cuenta                                                         f_nro_cuenta,
                                  CASE
                                    WHEN f633_tipo_cuenta = 1 THEN 'Corriente'
                                    WHEN f633_tipo_cuenta = 2 THEN 'Ahorros'
                                    WHEN f633_tipo_cuenta = 3 THEN 'Fiducia'
                                    WHEN Isnull(f633_tipo_cuenta, '') = '' THEN ' '
                                  END                                                                        f_tipo_cuenta,
                                  CASE
                                    WHEN t470_comp.f470_ind_naturaleza = 2 THEN -t470_comp.f470_costo_prom_tot
                                    ELSE t470_comp.f470_costo_prom_tot
                                  END                                                                        f_costo_prom,
                                  CASE
                                    WHEN t470_comp.f470_ind_naturaleza = 2 THEN -t470_comp.f470_costo_prom_uni
                                    ELSE t470_comp.f470_costo_prom_uni
                                  END                                                                        f_costo_prom_uni,
								  t470_comp.f470_id_lote                                                     f_lote,
								  t470_comp.f470_rowid_item_ext												f_item_ext_lote
  FROM   t470_cm_movto_invent t470_comp
         INNER JOIN t010_mm_companias
                 ON f010_id = t470_comp.f470_id_cia
         INNER JOIN t350_co_docto_contable t350_t1
                 ON t350_t1.f350_rowid = t470_comp.f470_rowid_docto
         INNER JOIN t451_cm_docto_compras
                 ON f451_rowid_docto = t470_comp.f470_rowid_docto
         INNER JOIN t145_mc_conceptos
                 ON f145_id = t470_comp.f470_id_concepto
         INNER JOIN t146_mc_motivos
                 ON f146_id_cia = t470_comp.f470_id_cia
                    AND f146_id_concepto = t470_comp.f470_id_concepto
                    AND f146_id = t470_comp.f470_id_motivo
         INNER JOIN t200_mm_terceros tproveedor
                 ON tproveedor.f200_rowid = f451_rowid_tercero_prov
         INNER JOIN v121 item_inv
                 ON item_inv.v121_rowid_item_ext = t470_comp.f470_rowid_item_ext
         INNER JOIN t150_mc_bodegas t150
                 ON t150.f150_rowid = t470_comp.f470_rowid_bodega
         INNER JOIN t200_mm_terceros tcomprador
                 ON tcomprador.f200_rowid = f451_rowid_comprador
         INNER JOIN t028_mm_clases_documento
                 ON f028_id = f451_id_clase_docto
         INNER JOIN t054_mm_estados estado_co
                 ON f028_id_grupo_clase_docto = estado_co.f054_id_grupo_clase_docto
                    AND estado_co.f054_id = t470_comp.f470_ind_estado_cm
          INNER JOIN t680_in_biable t680
               ON ( t680.f680_ind_filtrar_cia = 0
                     OR ( t680.f680_ind_filtrar_cia = 1
                          AND t680.f680_id_cia = f470_id_cia ) )
			
         LEFT JOIN t107_mc_proyectos
                ON f107_id_cia = t470_comp.f470_id_cia
                   AND f107_id = t470_comp.f470_id_proyecto
         LEFT OUTER JOIN t421_cm_oc_movto t420_oc_movto
                      ON t470_comp.f470_rowid_oc_movto = t420_oc_movto.f421_rowid
         LEFT OUTER JOIN t420_cm_oc_docto t420_oc_docto
                      ON t420_oc_movto.f421_rowid_oc_docto = t420_oc_docto.f420_rowid
         LEFT OUTER JOIN t421_cm_oc_movto t420_sc_movto
                      ON t420_sc_movto.f421_rowid = t420_oc_movto.f421_rowid_oc_movto
         LEFT OUTER JOIN t420_cm_oc_docto t420_sc_docto
                      ON t420_sc_docto.f420_rowid = t420_sc_movto.f421_rowid_oc_docto
         LEFT OUTER JOIN t350_co_docto_contable t350_t2
                      ON f451_rowid_docto_factura = t350_t2.f350_rowid
         LEFT JOIN t455_cm_factura_docto
                ON f455_rowid_docto = f451_rowid_docto_factura
         LEFT OUTER JOIN t284_co_ccosto
                      ON f284_rowid = t470_comp.f470_rowid_ccosto_movto
         LEFT JOIN t122_mc_items_unidades
                ON item_inv.v121_id_cia = f122_id_cia
                   AND item_inv.v121_id_unidad_orden = f122_id_unidad
                   AND item_inv.v121_rowid_item = f122_rowid_item
         LEFT JOIN t121_mc_items_extensiones t121_sobre
                ON t121_sobre.f121_rowid = t470_comp.f470_rowid_item_ext_imp_compra
                   AND t470_comp.f470_rowid_item_ext_imp_compra <> t470_comp.f470_rowid_item_ext
         LEFT JOIN t120_mc_items t120_sobre
                ON t120_sobre.f120_rowid = t121_sobre.f121_rowid_item
         LEFT JOIN t126_mc_items_precios c126
                ON c126.f126_rowid_item = t120_sobre.f120_rowid
                   AND c126.f126_id_cia = t120_sobre.f120_id_cia
         LEFT JOIN t112_mc_listas_precios c112
                ON c126.f126_id_cia = c112.f112_id_cia
                   AND c112.f112_id = c126.f126_id_lista_precio
         LEFT JOIN (SELECT Min(f633_rowid)      f1_rowid,
                           f633_id_cia          f1_id_cia,
                           f633_rowid_proveedor f1_rowid_tercero_prov,
                           f633_id_sucursal     f1_id_sucursal_prov
                    FROM   t451_cm_docto_compras
                           INNER JOIN t633_pe_prov_cuenta
                                   ON f633_id_cia = f451_id_cia
                                      AND f633_rowid_proveedor = f451_rowid_tercero_prov
                                      AND f633_id_sucursal = f451_id_sucursal_prov
                    GROUP  BY f633_id_cia,
                              f633_rowid_proveedor,
                              f633_id_sucursal) t633_1
                ON f1_id_cia = f451_id_cia
                   AND f1_rowid_tercero_prov = f451_rowid_tercero_prov
                   AND f1_id_sucursal_prov = f451_id_sucursal_prov
         LEFT JOIN t633_pe_prov_cuenta
                ON f633_id_cia = f451_id_cia
                   AND f633_rowid = f1_rowid
         LEFT JOIN t016_mm_bancos
                ON f016_id = f633_id_banco
  WHERE  t350_t1.f350_id_clase_docto IN ( 405, 408, 409, 410,
                                          411, 412, 413, 414,
                                          417, 420, 427 ) 
										 

******************************
USE UnoEE_Pruebas;
--IF EXISTS (SELECT *
--           FROM   sys.views
--           WHERE  object_id = Object_id(N'BI_T461_1'))
--  DROP VIEW BI_T461_1

--GO

--CREATE VIEW BI_T461_1
--AS
  SELECT /*MOVIMIENTOS DE FACTURAS Y NOTAS*/ f461_id_cia                                                                     f_id_cia,
                                             t350_fact.f350_id_co                                                            f_co,
                                             t350_fact.f350_id_tipo_docto                                                    f_id_tipo_docto,
                                             t350_fact.f350_consec_docto                                                     f_nrodocto,
                                             CONVERT(VARCHAR(6), f461_id_fecha, 112)                                         f_periodo,
                                             CONVERT(CHAR(8), f461_id_fecha, 112)                                            f_fecha,
                                             CASE t350_fact.f350_ind_estado
                                               WHEN 0 THEN 'En elaboracion'
                                               WHEN 1 THEN 'Aprobado'
                                               WHEN 2 THEN 'Anulado'
                                             END                                                                             f_estado,
                                             f461_id_moneda_docto                                                            f_moneda_docto,
                                             f461_id_moneda_local                                                            f_moneda_local,
                                             f461_referencia                                                                 f_docto_referencia,
                                             f461_num_docto_referencia                                                       f_orden_compra,
                                             Isnull(( t350_rem.f350_id_tipo_docto + '-'
                                                      + dbo.Lpad(t350_rem.f350_consec_docto, 8, '0') ), ' ')                 f_documento_rem,
                                             t200_vend.f200_id                                                               f_vendedor,
                                             t210_vend_fac.f210_id                                                           f_cod_vendedor,
                                             f461_notas                                                                      f_notas,
                                             f215_id                                                                         f_punto_envio,
                                             t200_fact.f200_rowid                                                            f_rowid_cli_fact,
                                             t200_fact.f200_id                                                               f_cliente_fact,
                                             f461_id_sucursal_fact                                                           f_cliente_fact_suc,
                                             f461_id_tipo_cli_fact                                                           f_id_tipo_cliente,
                                             f278_descripcion                                                                f_desc_tipo_cliente,
                                             t201_fact.f201_id_grupo_dscto                                                   f_grupo_dscto_cli,
                                             t200_desp.f200_id                                                               f_cliente_desp,
                                             f461_id_sucursal_rem                                                            f_cliente_desp_suc,
                                             f160_id                                                                         f_cliente_ocasional,
                                             t200_corp.f200_id                                                               f_cliente_corp,
                                             t201_corp.f201_id_sucursal                                                      f_cliente_corp_suc,
                                             f461_id_cargue                                                                  f_cargue,
                                             f284_id                                                                         f_ccosto_movto,
                                             f150_id                                                                         f_bodega,
                                             f470_id_ubicacion_aux                                                           f_ubicacion,
                                             f470_id_lote                                                                    f_lote,
                                             f470_rowid_item_ext                                                             f_item_ext_lote,
                                             f470_id_concepto                                                                f_cpto_id,
                                             f120_referencia                                                                 f_ref_item,
                                             f120_id                                                                         f_item,
                                             f120_rowid                                                                      f_rowid_item,
                                             f121_rowid                                                                      f_rowid_item_ext,
                                             f470_id_lista_precio                                                            f_lista_precios,
                                             f120_id_grupo_dscto                                                             f_grupo_dscto_item,
                                             f120_id_grupo_impositivo                                                        f_grupo_impositivo,
                                             f120_id_unidad_inventario                                                       f_um_inv,
                                             ( f470_cant_1 * ( CASE f470_ind_naturaleza
                                                                 WHEN 1 THEN -1
                                                                 ELSE 1
                                                               END ) )                                                       f_cant_inv,
                                             f470_id_co_movto                                                                f_co_movto,
                                             f470_notas                                                                      f_notas_movto,
                                             ( f470_cant_base * ( CASE f470_ind_naturaleza
                                                                    WHEN 1 THEN -1
                                                                    ELSE 1
                                                                  END ) )                                                    f_cant_base,
                                             ( f470_cant_2 * ( CASE f470_ind_naturaleza
                                                                 WHEN 1 THEN -1
                                                                 ELSE 1
                                                               END ) )                                                       f_cant_adic,
                                             Isnull(v470_devol_cant_base, 0)                                                 f_cant_devuelta_base,
                                             Isnull(v470_devol_cant_2, 0)                                                    f_cant_devuelta_adic,
                                             Isnull(v470_devol_cant_1, 0)                                                    f_cant_devuelta_inv,
                                             CASE f470_ind_obsequio
                                               WHEN 0 THEN 'No'
                                               WHEN 1 THEN 'Si'
                                               WHEN 2 THEN 'Si y valorado'
                                             END                                                                             f_obsequio,
                                             f470_id_proyecto                                                                f_proyecto,
                                             f120_id_tipo_inv_serv                                                           f_tipo_inv,
                                             f149_descripcion                                                                f_desc_tipo_inv,
                                             f470_id_unidad_medida                                                           f_um_base,
                                             f120_id_unidad_adicional                                                        f_um_adic,
                                             f470_id_un_movto                                                                f_un_movto,
                                             f461_id_un_cxc                                                                  f_un_factura,
                                             CASE
                                               WHEN f461_id_moneda_docto = f010_id_moneda_local THEN ( f470_vlr_bruto * ( CASE f470_ind_naturaleza
                                                                                                                            WHEN 1 THEN -1
                                                                                                                            ELSE 1
                                                                                                                          END ) )
                                               ELSE( f470_vlr_bruto_alt * ( CASE f470_ind_naturaleza
                                                                              WHEN 1 THEN -1
                                                                              ELSE 1
                                                                            END ) )
                                             END                                                                             f_valor_bruto,
                                             ( f470_vlr_bruto * ( CASE f470_ind_naturaleza
                                                                    WHEN 1 THEN -1
                                                                    ELSE 1
                                                                  END ) )                                                    f_valor_bruto_local,
                                             CASE
                                               WHEN f461_id_moneda_docto = f010_id_moneda_local THEN ( f470_vlr_dscto_linea * ( CASE f470_ind_naturaleza
                                                                                                                                  WHEN 1 THEN -1
                                                                                                                                  ELSE 1
                                                                                                                                END ) )
                                               ELSE( f470_vlr_dscto_linea_alt * ( CASE f470_ind_naturaleza
                                                                                    WHEN 1 THEN -1
                                                                                    ELSE 1
                                                                                  END ) )
                                             END                                                                             f_valor_dscto_docto,
                                             ( f470_vlr_dscto_linea * ( CASE f470_ind_naturaleza
                                                                          WHEN 1 THEN -1
                                                                          ELSE 1
                                                                        END ) )                                              f_valor_dscto_local,
                                             CASE
                                               WHEN f461_id_moneda_docto = f010_id_moneda_local THEN ( f470_vlr_imp * ( CASE f470_ind_naturaleza
                                                                                                                          WHEN 1 THEN -1
                                                                                                                          ELSE 1
                                                                                                                        END ) )
                                               ELSE( f470_vlr_imp_alt * ( CASE f470_ind_naturaleza
                                                                            WHEN 1 THEN -1
                                                                            ELSE 1
                                                                          END ) )
                                             END                                                                             f_valor_imp_docto,
                                             ( f470_vlr_imp * ( CASE f470_ind_naturaleza
                                                                  WHEN 1 THEN -1
                                                                  ELSE 1
                                                                END ) )                                                      f_valor_imp_local,
                                             CASE
                                               WHEN f461_id_moneda_docto = f010_id_moneda_local THEN ( f470_vlr_neto * ( CASE f470_ind_naturaleza
                                                                                                                           WHEN 1 THEN -1
                                                                                                                           ELSE 1
                                                                                                                         END ) )
                                               ELSE( f470_vlr_neto_alt * ( CASE f470_ind_naturaleza
                                                                             WHEN 1 THEN -1
                                                                             ELSE 1
                                                                           END ) )
                                             END                                                                             f_valor_neto_docto,
                                             ( f470_vlr_neto * ( CASE f470_ind_naturaleza
                                                                   WHEN 1 THEN -1
                                                                   ELSE 1
                                                                 END ) )                                                     f_valor_neto_local,
                                             CASE
                                               WHEN f461_id_moneda_docto = f010_id_moneda_local THEN ( ( f470_vlr_bruto - f470_vlr_dscto_linea - f470_vlr_dscto_global ) * ( CASE f470_ind_naturaleza
                                                                                                                                                                               WHEN 1 THEN -1
                                                                                                                                                                               ELSE 1
                                                                                                                                                                             END ) )
                                               ELSE( ( f470_vlr_bruto_alt - f470_vlr_dscto_linea_alt - f470_vlr_dscto_global_alt ) * ( CASE f470_ind_naturaleza
                                                                                                                                         WHEN 1 THEN -1
                                                                                                                                         ELSE 1
                                                                                                                                       END ) )
                                             END                                                                             f_valor_sub_docto,
                                             ( ( f470_vlr_bruto - f470_vlr_dscto_linea - f470_vlr_dscto_global ) * ( CASE f470_ind_naturaleza
                                                                                                                       WHEN 1 THEN -1
                                                                                                                       ELSE 1
                                                                                                                     END ) ) f_valor_sub_local,
                                             ( ( f470_vlr_bruto - f470_vlr_dscto_linea - f470_vlr_dscto_global ) * ( CASE f470_ind_naturaleza
                                                                                                                       WHEN 1 THEN -1
                                                                                                                       ELSE 1
                                                                                                                     END ) ) f_valor_subtotal_local,--campo duplicado (necesario)
                                             t201_fact.f201_ind_calificacion                                                 f_calificacion,
                                             t680.f680_id                                                                    f_parametro_biable,
                                             t208_fact.f208_id                                                               f_condicion_pago,
                                             t208_fact.f208_descripcion                                                      f_desc_cond_pago,
                                             f146_id                                                                         f_motivo,
                                             f146_descripcion                                                                f_desc_motivo,
                                             ( ( f470_cant_base * t122e.f122_peso ) * ( CASE f470_ind_naturaleza
                                                                                          WHEN 1 THEN -1
                                                                                          ELSE 1
                                                                                        END ) )                              f_peso,
                                             t122e.f122_peso                                                                 f_factor_peso,
                                             ( ( f470_cant_base * t122e.f122_volumen ) * ( CASE f470_ind_naturaleza
                                                                                             WHEN 1 THEN -1
                                                                                             ELSE 1
                                                                                           END ) )                           f_volumen,
                                             t122e.f122_volumen                                                              f_factor_volumen,
                                             ( f470_costo_prom_uni * ( CASE f470_ind_naturaleza
                                                                         WHEN 1 THEN -1
                                                                         ELSE 1
                                                                       END ) )                                               f_costo_prom_uni,
                                             ( f470_costo_prom_tot * ( CASE f470_ind_naturaleza
                                                                         WHEN 1 THEN -1
                                                                         ELSE 1
                                                                       END ) )                                               f_costo_prom_tot,
                                             CASE
                                               WHEN f112_ind_tipo_lista = 3 THEN f470_precio_uni
                                               ELSE dbo.F_generico_hallar_prec_vta(f470_id_cia, f470_id_lista_precio, f470_rowid_item_ext, f470_id_fecha, f470_id_unidad_medida)
                                             END                                                                             f_precio,
                                             CASE
                                               WHEN f112_ind_tipo_lista = 3 THEN 0
                                               ELSE dbo.F_generico_hallar_prec_vta_min (f470_id_cia, f470_id_lista_precio, f470_rowid_item_ext, f470_id_fecha, f470_id_unidad_medida)
                                             END                                                                             f_precio_minimo,
                                             CASE
                                               WHEN f112_ind_tipo_lista = 3 THEN 0
                                               ELSE dbo.F_generico_hallar_prec_vta_max (f470_id_cia, f470_id_lista_precio, f470_rowid_item_ext, f470_id_fecha, f470_id_unidad_medida)
                                             END                                                                             AS f_precio_maximo,
                                             Isnull(t470_cm_movto_invent.f470_id_causal_devol, ' ')                          f_causal_devol,
                                             Isnull(t158_causal_dev.f158_descripcion, ' ')                                   f_desc_devol,
                                             f470_precio_uni                                                                 f_precio_venta,
                                             ( f470_vlr_imp_margen * ( CASE f470_ind_naturaleza
                                                                         WHEN 1 THEN -1
                                                                         ELSE 1
                                                                       END ) )                                               f_imp_afecta_margen,
                                             Isnull(t200_super_super.f200_razon_social, ' ')                                 f_supervisor,
                                             Isnull(t200_super_super.f200_id, ' ')                                           f_id_supervisor,
                                             f025_id                                                                         f_id_medio_pago,
                                             f025_descripcion                                                                f_medio_pago,
                                             f461_rowid_tercero_fact                                                         f_rowid_tercero_fact,
                                             t201_fact.f201_rowid_tercero_corp                                               f_rowid_tercero_corp,
                                             f461_rowid_tercero_rem                                                          f_rowid_tercero_desp,
                                             t430_ped.f430_id_fecha                                                          f_fecha_pedido,
                                             dbo.Lpad(t430_ped.f430_consec_docto, 8, '0')                                    f_nro_docto_ped,
                                             t430_ped.f430_id_tipo_docto                                                     f_tipo_docto_ped,
                                             t350_cruce.f350_consec_docto                                                    f_nro_docto_cruce,
                                             t350_cruce.f350_id_tipo_docto                                                   f_tipo_docto_cruce,
                                             t350_cruce.f350_fecha                                                           f_fecha_docto_cruce,
                                             t201_fact.f201_id_cond_pago                                                     f_cond_pago_cli,
                                             t208_cli.f208_descripcion                                                       f_desc_pago_cli,
                                             Ltrim(Rtrim(t013.f013_id_pais + t013.f013_id_depto
                                                         + t013.f013_id))                                                    f_id_ciudad_desp,
                                             t013.f013_descripcion                                                           f_ciudad_desp,
                                             Isnull(( f470_cant_base * f122_volumen * ( CASE f470_ind_naturaleza
                                                                                          WHEN 1 THEN -1
                                                                                          ELSE 1
                                                                                        END ) ), 0)                          f_vol,
                                             f461_id_clase_docto                                                             f_id_clase_docto,
                                             f028_descripcion                                                                f_clase_docto,
                                             CASE t350_fact.f350_ind_estado
                                               WHEN 2 THEN 0
                                               ELSE
                                                 CASE
                                                   WHEN f461_id_moneda_docto = f010_id_moneda_local THEN f461_vlr_caja
                                                   ELSE dbo.F_generico_hallar_vlr_alterno(f461_id_moneda_docto, f461_id_moneda_conv, f461_id_moneda_local, f461_ind_forma_conv, f461_ind_forma_local, f461_tasa_conv, f461_tasa_local, 4, f461_vlr_caja)
                                                 END
                                             END                                                                             f_valor_caja,
                                             CASE t350_fact.f350_ind_estado
                                               WHEN 2 THEN 0
                                               ELSE f461_vlr_caja
                                             END                                                                             f_valor_caja_local,
                                             CASE f120_ind_tipo_item
                                               WHEN 1 THEN 'Inventario'
                                               WHEN 2 THEN 'Servicio'
                                               WHEN 3 THEN 'Kits'
                                               WHEN 4 THEN 'Fantasma'
                                             END                                                                             f_tipo_item,
                                             dbo.F_generico_hallar_ult_ref_alt (f461_id_cia, f120_rowid)                     f_ref_alterna,
                                             CASE ( ( CASE Isnull(f100_ind_calculo_margen_vta, 0)
                                                        WHEN 0 THEN ( ( f470_vlr_bruto - f470_vlr_dscto_linea - f470_vlr_dscto_global ) + f470_vlr_imp_margen )
                                                        ELSE ( f470_costo_mp_en + f470_costo_mp_np )
                                                      END ) * ( CASE f470_ind_naturaleza
                                                                  WHEN 1 THEN -1
                                                                  ELSE 1
                                                                END ) )
                                               WHEN 0 THEN 0
                                               ELSE ( ( ( ( ( ( f470_vlr_bruto - f470_vlr_dscto_linea - f470_vlr_dscto_global ) + f470_vlr_imp_margen ) - ( f470_costo_mp_en + f470_costo_mp_np ) ) * ( CASE f470_ind_naturaleza
                                                                                                                                                                                                          WHEN 1 THEN -1
                                                                                                                                                                                                          ELSE 1
                                                                                                                                                                                                        END ) ) / ( ( CASE Isnull(f100_ind_calculo_margen_vta, 0)
                                                                                                                                                                                                                        WHEN 0 THEN ( ( f470_vlr_bruto - f470_vlr_dscto_linea - f470_vlr_dscto_global ) + f470_vlr_imp_margen )
                                                                                                                                                                                                                      END ) * ( CASE f470_ind_naturaleza
                                                                                                                                                                                                                                  WHEN 1 THEN -1
                                                                                                                                                                                                                                  ELSE 1
                                                                                                                                                                                                                                END ) ) ) * 100 )
                                             END                                                                             f_margen_mp,
                                             CASE ( ( CASE Isnull(f100_ind_calculo_margen_vta, 0)
                                                        WHEN 0 THEN ( ( f470_vlr_bruto - f470_vlr_dscto_linea - f470_vlr_dscto_global ) + f470_vlr_imp_margen )
                                                        ELSE f470_costo_prom_tot
                                                      END ) * ( CASE f470_ind_naturaleza
                                                                  WHEN 1 THEN -1
                                                                  ELSE 1
                                                                END ) )
                                               WHEN 0 THEN 0
                                               ELSE ( ( ( ( ( ( f470_vlr_bruto - f470_vlr_dscto_linea - f470_vlr_dscto_global ) + f470_vlr_imp_margen ) - f470_costo_prom_tot ) * ( CASE f470_ind_naturaleza
                                                                                                                                                                                      WHEN 1 THEN -1
                                                                                                                                                                                      ELSE 1
                                                                                                                                                                                    END ) ) / ( ( CASE Isnull(f100_ind_calculo_margen_vta, 0)
                                                                                                                                                                                                    WHEN 0 THEN ( ( f470_vlr_bruto - f470_vlr_dscto_linea - f470_vlr_dscto_global ) + f470_vlr_imp_margen )
                                                                                                                                                                                                    ELSE f470_costo_prom_tot
                                                                                                                                                                                                  END ) * ( CASE f470_ind_naturaleza
                                                                                                                                                                                                              WHEN 1 THEN -1
                                                                                                                                                                                                              ELSE 1
                                                                                                                                                                                                            END ) ) ) * 100 )
                                             END                                                                             f_margen_promedio,
                                             Isnull(Round(( f470_cant_1 / Isnull(t122e.f122_factor, 1) ) * ( CASE f470_ind_naturaleza
                                                                                                               WHEN 1 THEN -1
                                                                                                               ELSE 1
                                                                                                             END ), 4), 0)   f_cant_emp,
                                             t680.f680_id_plan_item_1                                                        f_plan_item_1,
                                             t680.f680_id_plan_item_2                                                        f_plan_item_2,
                                             t680.f680_id_plan_item_3                                                        f_plan_item_3,
                                             t680.f680_id_plan_item_4                                                        f_plan_item_4,
                                             t680.f680_id_plan_item_5                                                        f_plan_item_5,
                                             t680.f680_id_plan_item_6                                                        f_plan_item_6,
                                             t680.f680_id_plan_item_7                                                        f_plan_item_7,
                                             t680.f680_id_plan_item_8                                                        f_plan_item_8,
                                             t680.f680_id_plan_item_9                                                        f_plan_item_9,
                                             t680.f680_id_plan_item_10                                                       f_plan_item_10
  FROM   t350_co_docto_contable t350_fact
         INNER JOIN t461_cm_docto_factura_venta
                 ON f461_rowid_docto = t350_fact.f350_rowid
         INNER JOIN t278_co_tipo_cli
                 ON f278_id_cia = f461_id_cia
                    AND f278_id = f461_id_tipo_cli_fact
         INNER JOIN t208_mm_condiciones_pago t208_fact
                 ON f461_id_cond_pago = t208_fact.f208_id
                    AND t208_fact.f208_id_cia = f461_id_cia
         LEFT JOIN t025_mm_medios_pago
                ON f025_id_cia = f461_id_cia
                   AND f025_id = f208_id_medio_pago
         INNER JOIN t470_cm_movto_invent --WITH(INDEX(ix_t470_4))
                 ON f470_rowid_docto_fact = f461_rowid_docto
         INNER JOIN t146_mc_motivos
                 ON f470_id_concepto = f146_id_concepto
                    AND f470_id_motivo = f146_id
                    AND f470_id_cia = f146_id_cia
         INNER JOIN t150_mc_bodegas t150
                 ON t150.f150_rowid = f470_rowid_bodega
         INNER JOIN t121_mc_items_extensiones
                 ON f121_rowid = f470_rowid_item_ext
         INNER JOIN t120_mc_items
                 ON f120_rowid = f121_rowid_item
         LEFT JOIN t122_mc_items_unidades t122e
                ON t122e.f122_rowid_item = f121_rowid_item
                   AND t122e.f122_id_unidad = f470_id_unidad_medida
                   AND t122e.f122_id_cia = f470_id_cia
         LEFT JOIN t010_mm_companias
                ON f010_id = f461_id_cia
         INNER JOIN t200_mm_terceros t200_fact
                 ON t200_fact.f200_rowid = f461_rowid_tercero_fact
         INNER JOIN t201_mm_clientes t201_fact
                 ON t201_fact.f201_rowid_tercero = f461_rowid_tercero_fact
                    AND t201_fact.f201_id_sucursal = f461_id_sucursal_fact
         INNER JOIN t200_mm_terceros t200_desp
                 ON t200_desp.f200_rowid = f461_rowid_tercero_rem
         INNER JOIN t200_mm_terceros t200_vend
                 ON t200_vend.f200_rowid = f461_rowid_tercero_vendedor
         INNER JOIN v470_ventas_devol
                 ON v470_devol_rowid_movto = f470_rowid
         INNER JOIN t680_in_biable t680
                 ON ( t680.f680_ind_filtrar_cia = 0
                       OR ( t680.f680_ind_filtrar_cia = 1
                            AND t680.f680_id_cia = f461_id_cia ) )
         INNER JOIN t028_mm_clases_documento
                 ON f028_id = f461_id_clase_docto
         LEFT JOIN t284_co_ccosto
                ON f284_rowid = f470_rowid_ccosto_movto
         LEFT JOIN t200_mm_terceros t200_corp
                ON t200_corp.f200_rowid = t201_fact.f201_rowid_tercero_corp
         LEFT JOIN t201_mm_clientes t201_corp
                ON t201_corp.f201_rowid_tercero = t201_fact.f201_rowid_tercero_corp
                   AND t201_corp.f201_id_sucursal = t201_fact.f201_id_sucursal_corp
         LEFT JOIN t160_mc_cli_contado
                ON f160_rowid = f461_rowid_cli_contado
         LEFT JOIN t215_mm_puntos_envio_cliente
                ON f215_rowid = f461_rowid_punto_envio_rem
         LEFT JOIN t350_co_docto_contable t350_rem
                ON t350_rem.f350_rowid = f470_rowid_docto
         LEFT JOIN t100_pp_comerciales
                ON f100_id_cia = f470_id_cia
         LEFT JOIN t158_mc_causal_devol t158_causal_dev
                ON t158_causal_dev.f158_id_cia = f470_id_cia
                   AND t158_causal_dev.f158_id_concepto = f470_id_concepto
                   AND t158_causal_dev.f158_id = f470_id_causal_devol
         LEFT JOIN t112_mc_listas_precios
                ON f112_id_cia = f461_id_cia
                   AND f112_id = f470_id_lista_precio
         LEFT JOIN t149_mc_tipo_inv_serv
                ON f120_id_tipo_inv_serv = f149_id
                   AND f120_id_cia = f149_id_cia
         LEFT JOIN t210_mm_vendedores t210_vend_fac
                ON t210_vend_fac.f210_rowid_tercero = f461_rowid_tercero_vendedor
         LEFT JOIN t200_mm_terceros t200_super
                ON t200_super.f200_rowid = t210_vend_fac.f210_rowid_terc_supervisor
         LEFT JOIN t210_mm_vendedores t210_super
                ON t210_super.f210_rowid_tercero = t200_super.f200_rowid
         LEFT JOIN t200_mm_terceros t200_super_super
                ON t200_super_super.f200_rowid = t210_super.f210_rowid_terc_supervisor
         LEFT JOIN t460_cm_docto_remision_venta t460_ped
                ON t460_ped.f460_rowid_docto = f470_rowid_docto
         LEFT JOIN t430_cm_pv_docto t430_ped
                ON t430_ped.f430_rowid = t460_ped.f460_rowid_pv_docto
         LEFT JOIN t350_co_docto_contable t350_cruce
                ON t350_cruce.f350_rowid = f461_rowid_docto_factura_base
         LEFT JOIN t208_mm_condiciones_pago t208_cli
                ON t201_fact.f201_id_cond_pago = t208_cli.f208_id
                   AND t208_cli.f208_id_cia = t201_fact.f201_id_cia
         LEFT JOIN t015_mm_contactos AS t015
                ON t015.f015_rowid = t200_desp.f200_rowid_contacto
         LEFT JOIN t013_mm_ciudades AS t013
                ON t013.f013_id_pais = t015.f015_id_pais
                   AND t013.f013_id_depto = t015.f015_id_depto
                   AND t013.f013_id = f015_id_ciudad

GO



******************************
--1.17.131 --1.17.331 --1.17.531 --1.17.731 --1.17.929 --1.17.1130 --1.18.131 --1.18.328 
--IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'BI_T470'))
-- DROP VIEW BI_T470
--GO

--CREATE VIEW BI_T470
--AS

SELECT /*MOVIMIENTO DE INVENTARIO*/ 
       t470_inv.f470_id_cia							f_cia,
       t150.f150_id							f_bodega,
	   t470_inv.f470_id_instalacion					f_instalacion,
       isnull(t470_inv.f470_id_lote, ' ')			f_lote,
       t470_inv.f470_rowid_item_ext                  f_rowid_item_lote,
       f285_id                              f_id_co,
       isnull(t470_inv.f470_id_ubicacion_aux, ' ')	f_ubicacion,
       t003.f003_descripcion				f_modulo_desc,
       t470_inv.f470_id_concepto						f_cpto,
       f145_descripcion						f_desc_cpto,
       t470_inv.f470_id_motivo						f_motivo,
       f146_descripcion						f_desc_motivo,
       isnull(t470_inv.f470_id_un_movto,' ')			f_un,
       isnull(f284_id, ' ')					f_ccosto,
       isnull(t470_inv.f470_id_proyecto,' ')			f_proyecto,
       f107_descripcion						f_desc_proyecto,
       isnull(t_terc.f200_id, ' ')			f_tercero,
       t120_item.f120_id_tipo_inv_serv		f_tipo_inv,
	   f149_descripcion						f_desc_tipo_inv,
       convert(varchar(6), t470_inv.f470_id_fecha,112)	
											f_periodo,       
       convert(char(8),t470_inv.f470_id_fecha,112) f_fecha,
       t350_inv.f350_id_tipo_docto					f_tipo_docto,
       t350_inv.f350_consec_docto					f_docto,
       t350_inv.f350_ind_estado						f_ind_estado, 
	   case t350_inv.f350_ind_estado 
	         when 0 then 'En elaboración' 
			 when 1 then 'Aprobadas'
			 when 2 then 'Anuladas'
			 WHEN 3	then 'Contabilizado'			
	   end f_estado,    
       t120_item.f120_id					f_item,
	   t120_item.f120_rowid					f_rowid_item,
	   t121_item.f121_rowid                 f_rowid_item_ext,	
       t120_item.f120_id_unidad_inventario	f_um,
       isnull(t120_item.f120_id_unidad_adicional,' ') f_um_adic,
       t120_item.f120_id_grupo_impositivo	f_grupo_impositivo,
       t350_inv.f350_referencia						f_docto_alterno,
       t470_inv.f470_notas							f_notas_movto,
       t350_inv.f350_notas							f_notas_docto,
       t_umi.f122_peso						f_peso,
       CASE
          WHEN t120_item.f120_id_unidad_empaque IS NOT NULL THEN
           t120_item.f120_id_unidad_empaque
          ELSE
           t120_item.f120_id_unidad_inventario
       END f_um_emp,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               t470_inv.f470_cant_1
              ELSE
               0
           END) f_cant_ent_1,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 2 THEN
               t470_inv.f470_cant_1
              ELSE
               0
           END) f_cant_sal_1,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               t470_inv.f470_cant_1
              ELSE
               - (t470_inv.f470_cant_1)
           END) f_cant_net_1,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               t470_inv.f470_cant_2
              ELSE
               0
           END) f_cant_ent_2,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 2 THEN
               t470_inv.f470_cant_2
              ELSE
               0
           END) f_cant_sal_2,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               t470_inv.f470_cant_2
              ELSE
               - (t470_inv.f470_cant_2)
           END) f_cant_net_2,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               round(t470_inv.f470_cant_1 / isnull(t_ume.f122_factor, 1), 4)
              ELSE
               0
           END) f_cant_ent_emp,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 2 THEN
               round(t470_inv.f470_cant_1 / isnull(t_ume.f122_factor, 1), 4)
              ELSE
               0
           END) f_cant_sal_emp,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               round(t470_inv.f470_cant_1 / isnull(t_ume.f122_factor, 1), 4)
              ELSE
               - (round(t470_inv.f470_cant_1 / isnull(t_ume.f122_factor, 1), 4))
           END) f_cant_net_emp,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               round(t470_inv.f470_cant_1 * t_umi.f122_peso, 4)
              ELSE
               0
           END) f_cant_ent_peso,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 2 THEN
               round(t470_inv.f470_cant_1 * t_umi.f122_peso, 4)
              ELSE
               0
           END) f_cant_sal_peso,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               round(t470_inv.f470_cant_1 * t_umi.f122_peso, 4)
              ELSE
               - (round(t470_inv.f470_cant_1 * t_umi.f122_peso, 4))
           END) f_cant_net_peso,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               round(t470_inv.f470_cant_1 * t_umi.f122_volumen, 4)
              ELSE
               0
           END) f_cant_ent_vol,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 2 THEN
               round(t470_inv.f470_cant_1 * t_umi.f122_volumen, 4)
              ELSE
               0
           END) f_cant_sal_vol,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               round(t470_inv.f470_cant_1 * t_umi.f122_volumen, 4)
              ELSE
               - (round(t470_inv.f470_cant_1 * t_umi.f122_volumen, 4))
           END) f_cant_net_vol,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               t470_inv.f470_costo_prom_tot
              ELSE
               0
           END) f_costo_prom_ent,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 2 THEN
               t470_inv.f470_costo_prom_tot
              ELSE
               0
           END) f_costo_prom_sal,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               t470_inv.f470_costo_prom_tot
              ELSE
               - (t470_inv.f470_costo_prom_tot)
           END) f_costo_prom_net,              
       
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               t470_inv.f470_costo_est_tot
              ELSE
               0
           END) f_costo_est_ent,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 2 THEN
               t470_inv.f470_costo_est_tot
              ELSE
               0
           END) f_costo_est_sal,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               t470_inv.f470_costo_est_tot
              ELSE
               - (t470_inv.f470_costo_est_tot)
           END) f_costo_est_net,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               isnull(t470_inv.f470_costo_mp_en + t470_inv.f470_costo_mp_np, 0)
              ELSE
               0
           END) f_costo_mp_ent,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               isnull(t470_inv.f470_costo_mp_en, 0)
              ELSE
               0
           END) f_costo_mp_en_ent,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               isnull(t470_inv.f470_costo_mp_np, 0)
              ELSE
               0
           END) f_costo_mp_np_ent,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               isnull(t470_inv.f470_costo_mo_en + t470_inv.f470_costo_mo_np, 0)
              ELSE
               0
           END) f_costo_mo_ent,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               isnull(t470_inv.f470_costo_mo_en, 0)
              ELSE
               0
           END) f_costo_mo_en_ent,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               isnull(t470_inv.f470_costo_mo_np, 0)
              ELSE
               0
           END) f_costo_mo_np_ent,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               isnull(t470_inv.f470_costo_cif_en + t470_inv.f470_costo_cif_np, 0)
              ELSE
               0
           END) f_costo_cif_ent,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               isnull(t470_inv.f470_costo_cif_en, 0)
              ELSE
               0
           END) f_costo_cif_en_ent,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 1 THEN
               isnull(t470_inv.f470_costo_cif_np, 0)
              ELSE
               0
           END) f_costo_cif_np_ent,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 2 THEN
               isnull(t470_inv.f470_costo_mp_en + t470_inv.f470_costo_mp_np, 0)
              ELSE
               0
           END) f_costo_mp_sal,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 2 THEN
               isnull(t470_inv.f470_costo_mp_en, 0)
              ELSE
               0
           END) f_costo_mp_en_sal,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 2 THEN
               isnull(t470_inv.f470_costo_mp_np, 0)
              ELSE
               0
           END) f_costo_mp_np_sal,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 2 THEN
               isnull(t470_inv.f470_costo_mo_en + t470_inv.f470_costo_mo_np, 0)
              ELSE
               0
           END) f_costo_mo_sal,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 2 THEN
               isnull(t470_inv.f470_costo_mo_en, 0)
              ELSE
               0
           END) f_costo_mo_en_sal,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 2 THEN
               isnull(t470_inv.f470_costo_mo_np, 0)
              ELSE
               0
           END) f_costo_mo_np_sal,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 2 THEN
               isnull(t470_inv.f470_costo_cif_en + t470_inv.f470_costo_cif_np, 0)
              ELSE
               0
           END) f_costo_cif_sal,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 2 THEN
               isnull(t470_inv.f470_costo_cif_en, 0)
              ELSE
               0
           END) f_costo_cif_en_sal,
       SUM(CASE t470_inv.f470_ind_naturaleza
              WHEN 2 THEN
               isnull(t470_inv.f470_costo_cif_np, 0)
              ELSE
               0
           END) f_costo_cif_np_sal, 
       isnull(t470_inv.f470_rowid_movto_proceso_ent,0) f_rowid_movto_proceso_ent,
       f400_cant_nivel_min_1  f_nivel_minimo,
       f400_cant_nivel_max_1  f_nivel_maximo,         
       f680_id f_parametro_biable,       	
       isnull(t120_sobre.f120_id,0)     f_cod_item_sobrecosto,       
       isnull(t120_sobre.f120_rowid,0)	f_rowid_item_sobrecosto,
	   isnull(t121_sobre.f121_rowid,0)  f_rowid_item_ext_sobrecosto ,
	   isnull(t350_sobre.f350_id_tipo_docto, '') f_tipo_docto_sobrecosto,
	   isnull(t350_sobre.f350_consec_docto,0) f_nro_docto_base_sobrecosto,
	    case t470_inv.f470_ind_naturaleza when 1 then 
			isnull(sal.f150_id,'') 
		else 
			isnull(ent.f150_id,'')
		end  f_id_bodega_orig_dest,
		case t470_inv.f470_ind_naturaleza when 1 then 
			isnull(sal.f150_descripcion,'') 
		else 
			isnull(ent.f150_descripcion,'')
		end  f_desc_bodega_orig_dest,
		CASE
         WHEN f440_consec_docto <> 0 THEN f440_id_co + '-' + f440_id_tipo_docto + '-'
                                          + dbo.Lpad(f440_consec_docto, 8, '0')
         ELSE ' '
       END f_docto_requisicion
	
  FROM t470_cm_movto_invent t470_inv --WITH(INDEX(ix_t470_20))
 INNER JOIN t150_mc_bodegas t150 ON t150.f150_rowid = t470_inv.f470_rowid_bodega                                     
 INNER JOIN t145_mc_conceptos t145 ON t145.f145_id = t470_inv.f470_id_concepto
 INNER JOIN t146_mc_motivos ON f146_id_cia = t470_inv.f470_id_cia AND f146_id_concepto = t470_inv.f470_id_concepto AND f146_id = t470_inv.f470_id_motivo
 INNER JOIN t003_pp_modulos t003 ON t003.f003_id = t145.f145_id_modulo
 INNER JOIN t350_co_docto_contable t350_inv ON t350_inv.f350_rowid = t470_inv.f470_rowid_docto 
 INNER JOIN t121_mc_items_extensiones t121_item ON t121_item.f121_rowid = t470_inv.f470_rowid_item_ext
 INNER JOIN t120_mc_items t120_item ON t120_item.f120_rowid = t121_item.f121_rowid_item
 LEFT JOIN t441_movto_req_int ON f441_rowid = t470_inv.f470_rowid_movto_req_int
 LEFT JOIN t440_docto_req_int ON f440_rowid = f441_rowid_docto_req_int
 INNER JOIN t122_mc_items_unidades t_umi ON t_umi.f122_rowid_item = f120_rowid
                                        AND t_umi.f122_id_unidad = f120_id_unidad_inventario
                                        AND t_umi.f122_id_cia  = f120_id_cia
 INNER JOIN t680_in_biable t680 ON (t680.f680_ind_filtrar_cia = 0 OR
                                   (t680.f680_ind_filtrar_cia = 1 AND
                                    t680.f680_id_cia = t470_inv.f470_id_cia))
 LEFT JOIN t400_cm_existencia ON f400_id_cia = t470_inv.f470_id_cia   
                              AND f400_rowid_item_ext = t470_inv.f470_rowid_item_ext 
                              AND f400_rowid_bodega =  t470_inv.f470_rowid_bodega
 LEFT JOIN t200_mm_terceros t_terc ON t_terc.f200_rowid = t350_inv.f350_rowid_tercero
  LEFT JOIN t284_co_ccosto ON f284_rowid = t470_inv.f470_rowid_ccosto_movto
  left join t285_co_centro_op on f285_id = t470_inv.f470_id_co_movto
                                 AND f285_id_cia = t470_inv.f470_id_cia
  LEFT JOIN t122_mc_items_unidades t_ume ON t_ume.f122_rowid_item = f120_rowid
                                        AND t_ume.f122_id_unidad = f120_id_unidad_empaque
                                        AND t_ume.f122_id_cia = f120_id_cia
  LEFT JOIN t107_mc_proyectos ON f107_id_cia = t470_inv.f470_id_cia AND f107_id = t470_inv.f470_id_proyecto  
  left join t121_mc_items_extensiones  t121_sobre on t121_sobre.f121_rowid= t470_inv.f470_rowid_item_ext_imp_compra and t470_inv.f470_rowid_item_ext_imp_compra <> t470_inv.f470_rowid_item_ext	
  left join t120_mc_items t120_sobre  on t120_sobre.f120_rowid = t121_sobre.f121_rowid_item    
  left join t470_cm_movto_invent t470_sobrecosto on t470_sobrecosto.f470_rowid = t470_inv.f470_rowid_mov_inv_imp_compra
  left join t350_co_docto_contable  t350_sobre on t350_sobre.f350_rowid = t470_sobrecosto.f470_rowid_docto
  left join t450_cm_docto_invent on f450_rowid_docto = t350_inv.f350_rowid
  left join t150_mc_bodegas sal on f450_rowid_bodega_salida = sal.f150_rowid
  left join t150_mc_bodegas ent  on f450_rowid_bodega_entrada = ent.f150_rowid
  left join t149_mc_tipo_inv_serv on t120_item.f120_id_tipo_inv_serv = f149_id 
								  and t120_item.f120_id_cia = f149_id_cia
WHERE t470_inv.f470_ind_estado_cm <> 2 
 GROUP BY t470_inv.f470_id_cia,
          t150.f150_id,
          t470_inv.f470_id_instalacion,
          isnull(t470_inv.f470_id_lote, ' '),
          t470_inv.f470_rowid_item_ext,
          f285_id,
          isnull(t470_inv.f470_id_ubicacion_aux, ' '),
          t003.f003_descripcion,
          t470_inv.f470_id_concepto,
          f145_descripcion,
          t470_inv.f470_id_motivo,
          f146_descripcion,
          t470_inv.f470_id_un_movto,
          isnull(f284_id, ' '),
          t470_inv.f470_id_proyecto,
          f107_descripcion,	
          isnull(t_terc.f200_id, ' '),
          t120_item.f120_id_tipo_inv_serv,
		  f149_descripcion,
          t470_inv.f470_id_fecha,
          t350_inv.f350_id_tipo_docto,
          t350_inv.f350_id_tipo_docto, 
          t350_inv.f350_consec_docto,
          t350_inv.f350_ind_estado,          
          t120_item.f120_id,
          t120_item.f120_rowid,
          t121_item.f121_rowid,
          t120_item.f120_id_unidad_inventario,
          t120_item.f120_id_unidad_adicional,
          CASE
             WHEN t120_item.f120_id_unidad_empaque IS NOT NULL THEN
              t120_item.f120_id_unidad_empaque
             ELSE
              t120_item.f120_id_unidad_inventario
          END,
          t120_item.f120_id_grupo_impositivo,
          t350_inv.f350_referencia,
          t470_inv.f470_notas,
          t350_inv.f350_notas,
          t_umi.f122_peso,
          isnull(t470_inv.f470_rowid_movto_proceso_ent,0),
          f400_cant_nivel_min_1,
          f400_cant_nivel_max_1,
          f680_id,
          isnull(t120_sobre.f120_id,0),         
          isnull(t120_sobre.f120_rowid,0),
	      isnull(t121_sobre.f121_rowid,0),
	      isnull(t350_sobre.f350_id_tipo_docto,''),
	      isnull(t350_sobre.f350_consec_docto,0),
		  case t470_inv.f470_ind_naturaleza when 1 then 
			  isnull(sal.f150_id,'') 
		  else 
			  isnull(ent.f150_id,'')
		  end ,
		  case t470_inv.f470_ind_naturaleza when 1 then 
				isnull(sal.f150_descripcion,'') 
		  else 
				isnull(ent.f150_descripcion,'')
		  end,
		  CASE
          WHEN f440_consec_docto <> 0 THEN f440_id_co + '-' + f440_id_tipo_docto + '-'
                                          + dbo.Lpad(f440_consec_docto, 8, '0')
         ELSE ' '
         END
			 	
          
GO

******************************
SELECT /* Saldos por cuenta */
       --t300.f300_id_cia compañia,
       --t681.f681_id_auxiliar id_auxiliar,
       --t681.f681_descripcion_auxiliar nombre_auxiliar,
       --t681.f681_id_plan id_plan_cuenta,
       --t681.f681_id_mayor id_mayor,
       --t681.f681_id_mayor_n1 cuenta_n1,
       --t681.f681_descripcion_mayor_n1 nombre_cuenta_n1,
       --t681.f681_id_mayor_n2 cuenta_n2,
       --t681.f681_descripcion_mayor_n2 nombre_cuenta_n2,
       --t681.f681_id_mayor_n3 cuenta_n3,
       --t681.f681_descripcion_mayor_n3 nombre_cuenta_n3,
       --t681.f681_id_mayor_n4 cuenta_n4,
       --t681.f681_descripcion_mayor_n4 nombre_cuenta_n4,
       --t681.f681_id_mayor_n5 cuenta_n5,
       --t681.f681_descripcion_mayor_n5 nombre_cuenta_n5,
       --t681.f681_id_mayor_n6 cuenta_n6,
       --t681.f681_descripcion_mayor_n6 nombre_cuenta_n6,
       --t681.f681_id_mayor_n7 cuenta_n7,
       --t681.f681_descripcion_mayor_n7 nombre_cuenta_n7,
       --t681.f681_id_mayor_n8 cuenta_n8,
       --t681.f681_descripcion_mayor_n8 nombre_cuenta_n8,
       --t300.f300_id_co id_co,
       --t285.f285_id_regional id_regional,
       --t300.f300_id_un id_un,
       --t300.f300_periodo periodo,
       --t300.f300_inicial saldo_inicial,
       --t300.f300_debitos debitos,
       --t300.f300_creditos creditos,
       --SUM(t300.f300_debitos - t300.f300_creditos) movimiento,
       SUM(t300.f300_inicial + t300.f300_debitos - t300.f300_creditos) saldo_final--,
       --t300.f300_inicial_alt saldo_inicial_alt,
       --t300.f300_debitos_alt debitos_alt,
       --t300.f300_creditos_alt creditos_alt,
       --t300.f300_debitos_alt - t300.f300_creditos_alt movimiento_alt,
       --t300.f300_inicial_alt + t300.f300_debitos_alt - t300.f300_creditos_alt saldo_final_alt,
       --t300.f300_inicial2 saldo_libro2,
       --t300.f300_debitos2 deb_libro2,
       --t300.f300_creditos2 cre_libro2,
       --t300.f300_inicial2+t300.f300_debitos2-t300.f300_creditos2 saldo_final_lib2,
       --t300.f300_debitos2-t300.f300_creditos2 movto_lib2,
       --t300.f300_inicial_alt2 saldo_alt_lib2,
       --t300.f300_debitos_alt2 deb_alt_lib2,
       --t300.f300_creditos_alt2 cre_alt_lib2,
       --t300.f300_inicial_alt2+t300.f300_debitos_alt2-t300.f300_creditos_alt2 sfinal_alt_lib2,
       --t300.f300_debitos_alt2-t300.f300_creditos_alt2 movto_alt_lib2,
       --t300.f300_inicial3 saldo_libro3,
       --t300.f300_debitos3 deb_libro3,
       --t300.f300_creditos3 cre_libro3,
       --t300.f300_inicial3+t300.f300_debitos3-t300.f300_creditos3 saldo_final_lib3,
       --t300.f300_debitos3-t300.f300_creditos3 movto_lib3,
       --t300.f300_inicial_alt3 saldo_alt_lib3,
       --t300.f300_debitos_alt3 deb_alt_lib3,
       --t300.f300_creditos_alt3 cre_alt_lib3,
       --t300.f300_inicial_alt3+t300.f300_debitos_alt3-t300.f300_creditos_alt3 sfinal_alt_lib3,
       --t300.f300_debitos_alt3-t300.f300_creditos_alt3 movto_alt_lib3,
       --t680.f680_id parametro_biable
  FROM t300_rc_auxiliar t300
 INNER JOIN t680_in_biable t680 ON (t680.f680_ind_filtrar_cia = 0 OR
                                   (t680.f680_ind_filtrar_cia = 1 AND
									t680.f680_id_cia = t300.f300_id_cia))
 INNER JOIN t010_mm_companias t010 ON t010.f010_id = t300.f300_id_cia
 INNER JOIN t285_co_centro_op t285 ON t285.f285_id_cia = t300.f300_id_cia
                                  AND t285.f285_id = t300.f300_id_co
 INNER JOIN t681_in_auxiliares_bi t681 ON t681.f681_rowid_auxiliar = t300.f300_rowid_auxiliar
								and t681.f681_id_plan = t680.f680_id_plan_cuenta

 WHERE t680.f680_id  = '1'
 AND ( t681.f681_id_auxiliar BETWEEN '1' AND '1z' )
 AND ( t300.f300_periodo BETWEEN 202304 AND 202304 )
--group by t681.f681_id_auxiliar
--HAVING SUM(t300.f300_inicial + t300.f300_debitos - t300.f300_creditos) = 11416574
******************************
--Prueba

  SELECT f120_id_cia,
         f120_id,
         f121_rowid,
         f120_referencia,
         f120_descripcion,
         f120_descripcion_corta,
         Isnull(w0006_1.c0006_descripcion, '') estado,
         Isnull(w0006_2.c0006_descripcion, '') f120_tipo_item,
         Isnull(w0006_3.c0006_descripcion, '') f120_item_para_compra,
         Isnull(w0006_4.c0006_descripcion, '') f120_item_para_venta,
         Isnull(w0006_5.c0006_descripcion, '') f120_item_para_manufactura,
         Isnull(w0006_6.c0006_descripcion, '') f120_maneja_lote,
         Isnull(w0006_7.c0006_descripcion, '') f120_maneja_serial,
         f120_id_unidad_inventario,
         f120_id_unidad_adicional,
         f120_id_unidad_orden,
         f120_id_unidad_empaque,
         f120_id_extension1,
         f121_id_ext1_detalle,
         f120_id_extension2,
         f121_id_ext2_detalle,
         t122_inv.f122_peso                    peso,
         t122_inv.f122_volumen                 volumen,
         t122_adic.f122_factor                 fact_adic,
         t122_ord.f122_factor                  fact_ord,
         t122_emp.f122_factor                  fact_emp,
         t125.id_cri_mayor_item_1              id_cri_mayor_item_1,
         t125.desc_cri_mayor_item_1            desc_cri_mayor_item_1,
         t125.id_cri_mayor_item_2              id_cri_mayor_item_2,
         t125.desc_cri_mayor_item_2            desc_cri_mayor_item_2,
         t125.id_cri_mayor_item_3              id_cri_mayor_item_3,
         t125.desc_cri_mayor_item_3            desc_cri_mayor_item_3,
         t125.id_cri_mayor_item_4              id_cri_mayor_item_4,
         t125.desc_cri_mayor_item_4            desc_cri_mayor_item_4,
         t125.id_cri_mayor_item_5              id_cri_mayor_item_5,
         t125.desc_cri_mayor_item_5            desc_cri_mayor_item_5,
         f120_notas,
         parametro_biable
  FROM   t120_mc_items
         LEFT JOIN t121_mc_items_extensiones
                ON f120_rowid = f121_rowid_item
         LEFT JOIN t122_mc_items_unidades t122_inv
                ON f120_rowid = t122_inv.f122_rowid_item
                   AND f120_id_cia = t122_inv.f122_id_cia
                   AND f120_id_unidad_inventario = t122_inv.f122_id_unidad
         LEFT JOIN t122_mc_items_unidades t122_adic
                ON f120_rowid = t122_adic.f122_rowid_item
                   AND f120_id_cia = t122_adic.f122_id_cia
                   AND f120_id_unidad_adicional = t122_adic.f122_id_unidad
         LEFT JOIN t122_mc_items_unidades t122_ord
                ON f120_rowid = t122_ord.f122_rowid_item
                   AND f120_id_cia = t122_ord.f122_id_cia
                   AND f120_id_unidad_orden = t122_ord.f122_id_unidad
         LEFT JOIN t122_mc_items_unidades t122_emp
                ON f120_rowid = t122_emp.f122_rowid_item
                   AND f120_id_cia = t122_emp.f122_id_cia
                   AND f120_id_unidad_empaque = t122_emp.f122_id_unidad
         LEFT JOIN w0006_tipos w0006_1
                ON w0006_1.c0006_id_tipo = 'f121_ind_estado'
                   AND w0006_1.c0006_id_lenguaje = '1'
                   AND w0006_1.c0006_valor = f121_ind_estado
         LEFT JOIN w0006_tipos w0006_2
                ON w0006_2.c0006_id_tipo = 'f120_ind_tipo_item'
                   AND w0006_2.c0006_id_lenguaje = '1'
                   AND w0006_2.c0006_valor = f120_ind_tipo_item
         LEFT JOIN w0006_tipos w0006_3
                ON w0006_3.c0006_id_tipo = 'f120_ind_compra'
                   AND w0006_3.c0006_id_lenguaje = '1'
                   AND w0006_3.c0006_valor = f120_ind_compra
         LEFT JOIN w0006_tipos w0006_4
                ON w0006_4.c0006_id_tipo = 'f120_ind_venta'
                   AND w0006_4.c0006_id_lenguaje = '1'
                   AND w0006_4.c0006_valor = f120_ind_venta
         LEFT JOIN w0006_tipos w0006_5
                ON w0006_5.c0006_id_tipo = 'f120_ind_manufactura'
                   AND w0006_5.c0006_id_lenguaje = '1'
                   AND w0006_5.c0006_valor = f120_ind_manufactura
         LEFT JOIN w0006_tipos w0006_6
                ON w0006_6.c0006_id_tipo = 'f120_ind_lote'
                   AND w0006_6.c0006_id_lenguaje = '1'
                   AND w0006_6.c0006_valor = f120_ind_lote
         LEFT JOIN w0006_tipos w0006_7
                ON w0006_7.c0006_id_tipo = 'f120_ind_serial'
                   AND w0006_7.c0006_id_lenguaje = '1'
                   AND w0006_7.c0006_valor = f120_ind_serial
         INNER JOIN BI_T125 t125
                 ON t125.rowid_item_ext = f121_rowid
         LEFT JOIN t680_in_biable
                ON T125.parametro_biable = f680_id
GO



******************************