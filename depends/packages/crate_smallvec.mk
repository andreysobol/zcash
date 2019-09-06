package=crate_smallvec
$(package)_crate_name=smallvec
$(package)_version=0.6.10
$(package)_download_path=https://static.crates.io/crates/$($(package)_crate_name)
$(package)_file_name=$($(package)_crate_name)-$($(package)_version).crate
$(package)_sha256_hash=ab606a9c5e214920bb66c458cd7be8ef094f813f20fe77a54cc7dbfff220d4b7
$(package)_crate_versioned_name=$($(package)_crate_name)

define $(package)_preprocess_cmds
  $(call generate_crate_checksum,$(package))
endef

define $(package)_stage_cmds
  $(call vendor_crate_source,$(package))
endef
