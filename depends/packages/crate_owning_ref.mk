package=crate_owning_ref
$(package)_crate_name=owning_ref
$(package)_version=0.4.0
$(package)_download_path=https://static.crates.io/crates/$($(package)_crate_name)
$(package)_file_name=$($(package)_crate_name)-$($(package)_version).crate
$(package)_sha256_hash=49a4b8ea2179e6a2e27411d3bca09ca6dd630821cf6894c6c7c8467a8ee7ef13
$(package)_crate_versioned_name=$($(package)_crate_name)

define $(package)_preprocess_cmds
  $(call generate_crate_checksum,$(package))
endef

define $(package)_stage_cmds
  $(call vendor_crate_source,$(package))
endef
