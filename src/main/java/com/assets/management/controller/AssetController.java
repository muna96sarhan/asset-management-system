package com.assets.management.controller;

import com.assets.management.model.Asset;
import com.assets.management.repository.AssetRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/assets")
@CrossOrigin(origins = "*") 
public class AssetController {

    @Autowired
    private AssetRepository assetRepository;

    // رابط جلب الأصول وتشغيل حساب الـ Procedure تلقائياً
    @GetMapping
    public ResponseEntity<List<Asset>> getAllAssets() {
        try {
            assetRepository.calculateAllAssetsDepreciation();
            List<Asset> assets = assetRepository.findAll();
            return ResponseEntity.ok(assets);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // رابط إضافة أصل أو عهدة جديدة للنظام
    @PostMapping
    public ResponseEntity<Asset> createAsset(@RequestBody Asset asset) {
        try {
            Asset savedAsset = assetRepository.save(asset);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedAsset);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}