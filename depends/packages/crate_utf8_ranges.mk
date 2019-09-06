package=crate_utf8_ranges
$(package)_crate_name=utf8-ranges
$(package)_version=1.0.4
$(package)_download_path=https://static.crates.io/crates/$($(package)_crate_name)
$(package)_file_name=$($(package)_crate_name)-$($(package)_version).crate
$(package)_sha256_hash=b4ae116fef2b7fea257ed6440d3cfcff7f190865f170cdad00bb6465bf18ecba
$(package)_crate_versioned_name=$($(package)_crate_name)

define $(package)_preprocess_cmds
  $(call generate_crate_checksum,$(package))
endef

define $(package)_stage_cmds
  $(call vendor_crate_source,$(package))
endef
