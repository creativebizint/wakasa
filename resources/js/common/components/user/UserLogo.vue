<template>
    <template v-if="user">
        {{ user.name }}
    </template>
    <template v-else>
        <span>
            {{ $t("user.walk_in_customer") }}
        </span>
    </template>
</template>

<script>
export default {
    props: {
        user: {
            default: {},
        },
        size: {
            default: 30,
        },
    },
};
</script>
