class FilterModule(object):
    def filters(self):
        return {
            'required_nonempty': self.required_nonempty
        }

    def required_nonempty(self, value, var_name='variable'):
        if value is None or (isinstance(value, str) and not value.strip()):
            raise ValueError(f"{var_name} must be defined and non-empty")
        return value