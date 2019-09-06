package=crate_aho_corasick
$(package)_crate_name=aho-corasick
$(package)_version=0.7.6
$(package)_download_path=https://static.crates.io/crates/$($(package)_crate_name)
$(package)_file_name=$($(package)_crate_name)-$($(package)_version).crate
$(package)_sha256_hash=58fb5e95d83b38284460a5fda7d6470aa0b8844d283a0b614b8535e880800d2d
$(package)_crate_versioned_name=$($(package)_crate_name)

define $(package)_preprocess_cmds
  $(call generate_crate_checksum,$(package))
endef

define $(package)_stage_cmds
  $(call vendor_crate_source,$(package))
endef
