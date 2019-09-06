package=crate_tracing_attributes
$(package)_crate_name=tracing-attributes
$(package)_version=0.1.2
$(package)_download_path=https://static.crates.io/crates/$($(package)_crate_name)
$(package)_file_name=$($(package)_crate_name)-$($(package)_version).crate
$(package)_sha256_hash=5b43a1835d0cb99f4a36fcdd0f777f72e4d4ff2eb6e78a0e105ac25e41309efa
$(package)_crate_versioned_name=$($(package)_crate_name)

define $(package)_preprocess_cmds
  $(call generate_crate_checksum,$(package))
endef

define $(package)_stage_cmds
  $(call vendor_crate_source,$(package))
endef
