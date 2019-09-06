package=crate_proc_macro2
$(package)_crate_name=proc-macro2
$(package)_version=1.0.2
$(package)_download_path=https://static.crates.io/crates/$($(package)_crate_name)
$(package)_file_name=$($(package)_crate_name)-$($(package)_version).crate
$(package)_sha256_hash=175a40b9cf564ce9bf050654633dbf339978706b8ead1a907bb970b63185dd95
$(package)_crate_versioned_name=$($(package)_crate_name)

define $(package)_preprocess_cmds
  $(call generate_crate_checksum,$(package))
endef

define $(package)_stage_cmds
  $(call vendor_crate_source,$(package))
endef
