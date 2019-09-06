package=crate_stable_deref_trait
$(package)_crate_name=stable_deref_trait
$(package)_version=1.1.1
$(package)_download_path=https://static.crates.io/crates/$($(package)_crate_name)
$(package)_file_name=$($(package)_crate_name)-$($(package)_version).crate
$(package)_sha256_hash=dba1a27d3efae4351c8051072d619e3ade2820635c3958d826bfea39d59b54c8
$(package)_crate_versioned_name=$($(package)_crate_name)

define $(package)_preprocess_cmds
  $(call generate_crate_checksum,$(package))
endef

define $(package)_stage_cmds
  $(call vendor_crate_source,$(package))
endef
