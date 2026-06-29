package com.assets.management.repository;

import com.assets.management.model.Asset;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;

@Repository
public interface AssetRepository extends JpaRepository<Asset, Long> {
    
    // استدعاء الـ Procedure المخزن في الـ MySQL لحساب إهلاك كفاءة الأصول
    @Procedure(procedureName = "Calculate_All_Assets_Depreciation")
    void calculateAllAssetsDepreciation();
}