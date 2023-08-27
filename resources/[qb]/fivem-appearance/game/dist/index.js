(() => {
    var F = e => new Promise(a => setTimeout(a, e)),
        H = e => {
            let a = GetEntityModel(e),
                o = GetHashKey("mp_m_freemode_01"),
                r = GetHashKey("mp_f_freemode_01");
            return a === o || a === r
        },
        g = e => {
            let a = GetEntityModel(e),
                o = GetHashKey("mp_m_freemode_01");
            return a === o
        };

    function h(e) {
        return {
            x: e[0],
            y: e[1],
            z: e[2]
        }
    }
    var se = () => {
            let e = PlayerPedId(),
                a = GetEntityHealth(e),
                o = GetPedArmour(e);
            return [a, o]
        },
        ce = (e, a) => {
            let o = PlayerPedId();
            SetEntityHealth(o, e), SetPedArmour(o, a)
        };
    var O = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
        D = [0, 1, 2, 6, 7],
        S = ["noseWidth", "nosePeakHigh", "nosePeakSize", "noseBoneHigh", "nosePeakLowering", "noseBoneTwist", "eyeBrownHigh", "eyeBrownForward", "cheeksBoneHigh", "cheeksBoneWidth", "cheeksWidth", "eyesOpening", "lipsThickness", "jawBoneWidth", "jawBoneBackSize", "chinBoneLowering", "chinBoneLenght", "chinBoneSize", "chinHole", "neckThickness"],
        k = ["blemishes", "beard", "eyebrows", "ageing", "makeUp", "blush", "complexion", "sunDamage", "lipstick", "moleAndFreckles", "chestHair", "bodyBlemishes"],
        de = ["Green", "Emerald", "Light Blue", "Ocean Blue", "Light Brown", "Dark Brown", "Hazel", "Dark Gray", "Light Gray", "Pink", "Yellow", "Purple", "Blackout", "Shades of Gray", "Tequila Sunrise", "Atomic", "Warp", "ECola", "Space Ranger", "Ying Yang", "Bullseye", "Lizard", "Dragon", "Extra Terrestrial", "Goat", "Smiley", "Possessed", "Demon", "Infected", "Alien", "Undead", "Zombie"];
    var _e = {
            ped: !0,
            headBlend: !0,
            faceFeatures: !0,
            headOverlays: !0,
            components: !0,
            props: !0,
            tattoos: !0
        },
        j = {
            head: {
                animations: {
                    on: {
                        dict: "mp_masks@standard_car@ds@",
                        anim: "put_on_mask",
                        move: 51,
                        duration: 600
                    },
                    off: {
                        dict: "missheist_agency2ahelmet",
                        anim: "take_off_helmet_stand",
                        move: 51,
                        duration: 1200
                    }
                },
                props: {
                    male: [
                        [1, 0]
                    ],
                    female: [
                        [1, 0]
                    ]
                }
            },
            body: {
                animations: {
                    on: {
                        dict: "clothingtie",
                        anim: "try_tie_negative_a",
                        move: 51,
                        duration: 1200
                    },
                    off: {
                        dict: "clothingtie",
                        anim: "try_tie_negative_a",
                        move: 51,
                        duration: 1200
                    }
                },
                props: {
                    male: [
                        [11, 15],
                        [3, 15],
                        [8, 15],
                        [10, 0],
                        [5, 0],
                        [9, 0]
                    ],
                    female: [
                        [11, 63],
                        [8, 14],
                        [3, 15],
                        [10, 0],
                        [5, 0],
                        [9, 0]
                    ]
                }
            },
            bottom: {
                animations: {
                    on: {
                        dict: "re@construction",
                        anim: "out_of_breath",
                        move: 51,
                        duration: 1300
                    },
                    off: {
                        dict: "re@construction",
                        anim: "out_of_breath",
                        move: 51,
                        duration: 1300
                    }
                },
                props: {
                    male: [
                        [4, 133],
                        [6, 133]
                    ],
                    female: [
                        [4, 13],
                        [6, 73]
                    ]
                }
            }
        };

    function ye() {
        RegisterNuiCallbackType("appearance_get_locales"), RegisterNuiCallbackType("appearance_get_settings_and_data"), RegisterNuiCallbackType("appearance_set_camera"), RegisterNuiCallbackType("appearance_turn_around"), RegisterNuiCallbackType("appearance_rotate_camera"), RegisterNuiCallbackType("appearance_change_model"), RegisterNuiCallbackType("appearance_change_head_blend"), RegisterNuiCallbackType("appearance_change_face_feature"), RegisterNuiCallbackType("appearance_change_hair"), RegisterNuiCallbackType("appearance_change_head_overlay"), RegisterNuiCallbackType("appearance_change_eye_color"), RegisterNuiCallbackType("appearance_change_component"), RegisterNuiCallbackType("appearance_change_prop"), RegisterNuiCallbackType("appearance_apply_tattoo"), RegisterNuiCallbackType("appearance_preview_tattoo"), RegisterNuiCallbackType("appearance_delete_tattoo"), RegisterNuiCallbackType("appearance_wear_clothes"), RegisterNuiCallbackType("appearance_remove_clothes"), RegisterNuiCallbackType("appearance_save"), RegisterNuiCallbackType("appearance_exit"), RegisterNuiCallbackType("rotate_left"), RegisterNuiCallbackType("rotate_right"), on("__cfx_nui:appearance_get_locales", (e, a) => {
            let o = LoadResourceFile(GetCurrentResourceName(), `locales/${GetConvar("fivem-appearance:locale","en")}.json`);
            a(o)
        }), on("__cfx_nui:appearance_get_settings_and_data", (e, a) => {
            let o = ue(),
                r = $(),
                t = Y();
            a({
                config: o,
                appearanceData: r,
                appearanceSettings: t
            })
        }), on("__cfx_nui:appearance_set_camera", (e, a) => {
            a({}), ee(e)
        }), on("__cfx_nui:appearance_turn_around", (e, a) => {
            a({}), B(PlayerPedId(), 180)
        }), on("__cfx_nui:appearance_rotate_camera", (e, a) => {
            a({}), me(e)
        }), on("__cfx_nui:appearance_change_model", async (e, a) => {
            await L(e);
            let o = PlayerPedId();
            SetEntityHeading(PlayerPedId(), Z), SetEntityInvincible(o, !0), TaskStandStill(o, -1);
            let r = x(o),
                t = Y();
            a({
                appearanceSettings: t,
                appearanceData: r
            })
        }), on("__cfx_nui:appearance_change_component", (e, a) => {
            let o = PlayerPedId();
            z(o, e), a(Q(o, e.component_id))
        }), on("__cfx_nui:appearance_change_prop", (e, a) => {
            let o = PlayerPedId();
            V(o, e), a(X(o, e.prop_id))
        }), on("__cfx_nui:appearance_change_head_blend", (e, a) => {
            a({}), M(PlayerPedId(), e)
        }), on("__cfx_nui:appearance_change_face_feature", (e, a) => {
            a({}), G(PlayerPedId(), e)
        }), on("__cfx_nui:appearance_change_head_overlay", (e, a) => {
            a({}), N(PlayerPedId(), e)
        }), on("__cfx_nui:appearance_change_hair", (e, a) => {
            let o = PlayerPedId();
            T(o, e), a(pe(o, e))
        }), on("__cfx_nui:appearance_change_eye_color", (e, a) => {
            a({}), A(PlayerPedId(), e)
        }), on("__cfx_nui:appearance_apply_tattoo", (e, a) => {
            a({}), fe(PlayerPedId(), e)
        }), on("__cfx_nui:appearance_preview_tattoo", (e, a) => {
            a({});
            let {
                data: o,
                tattoo: r
            } = e;
            he(PlayerPedId(), o, r)
        }), on("__cfx_nui:appearance_delete_tattoo", (e, a) => {
            a({}), ge(PlayerPedId(), e)
        }), on("__cfx_nui:appearance_wear_clothes", (e, a) => {
            a({});
            let {
                data: o,
                key: r
            } = e;
            Pe(o, r)
        }), on("__cfx_nui:appearance_remove_clothes", (e, a) => {
            a({}), ve(e)
        }), on("__cfx_nui:appearance_save", (e, a) => {
            a({}), J(e)
        }), on("__cfx_nui:appearance_exit", (e, a) => {
            a({}), J()
        }), on("__cfx_nui:rotate_left", (e, a) => {
            a({}), B(PlayerPedId(), 10)
        }), on("__cfx_nui:rotate_right", (e, a) => {
            a({}), B(PlayerPedId(), -10)
        })
    }
    var Ie = global.exports,
        Ce = {
            default: {
                coords: {
                    x: 0,
                    y: 2.2,
                    z: .2
                },
                point: {
                    x: 0,
                    y: 0,
                    z: -.05
                }
            },
            head: {
                coords: {
                    x: 0,
                    y: .9,
                    z: .65
                },
                point: {
                    x: 0,
                    y: 0,
                    z: .6
                }
            },
            body: {
                coords: {
                    x: 0,
                    y: 1.2,
                    z: .2
                },
                point: {
                    x: 0,
                    y: 0,
                    z: .2
                }
            },
            bottom: {
                coords: {
                    x: 0,
                    y: .98,
                    z: -.7
                },
                point: {
                    x: 0,
                    y: 0,
                    z: -.9
                }
            }
        },
        Ee = {
            default: {
                x: 1.5,
                y: -1
            },
            head: {
                x: .7,
                y: -.45
            },
            body: {
                x: 1.2,
                y: -.45
            },
            bottom: {
                x: .7,
                y: -.45
            }
        },
        U, oe, I, E, Z, m, w, b, C, He = {};

    function xe() {
        let e = {
            hair: [],
            makeUp: []
        };
        for (let a = 0; a < GetNumHairColors(); a++) e.hair.push(GetPedHairRgbColor(a));
        for (let a = 0; a < GetNumMakeupColors(); a++) e.makeUp.push(GetMakeupRgbColor(a));
        return e
    }

    function $() {
        return I || (I = x(PlayerPedId())), I
    }

    function v(e, a) {
        for (var o = {
                drawables: [],
                textures: []
            }, r = 0; r < e.length; r++) {
            if (e[r].drawable === a && e[r].textures !== void 0)
                for (var t = 0; t < e[r].textures.length; t++) o.textures.push(e[r].textures[t]);
            (e[r].textures === void 0 || e[r].textures.length == 0) && o.drawables.push(e[r].drawable)
        }
        return o
    }

    function Q(e, a) {
        let o = GetPedDrawableVariation(e, a),
            r = g(e);
        var t = {
                drawables: [],
                textures: []
            },
            i = ae.male;
        if (r || (i = ae.female), H(e)) switch (a) {
        case 1:
            t = v(i.masks, o);
            break;
        case 3:
            t = v(i.upperBody, o);
            break;
        case 4:
            t = v(i.lowerBody, o);
            break;
        case 5:
            t = v(i.bags, o);
            break;
        case 6:
            t = v(i.shoes, o);
            break;
        case 7:
            t = v(i.scarfAndChains, o);
            break;
        case 8:
            t = v(i.shirts, o);
            break;
        case 9:
            t = v(i.bodyArmor, o);
            break;
        case 10:
            t = v(i.decals, o);
            break;
        case 11:
            t = v(i.jackets, o);
            break;
        default:
            break
        }
        return {
            component_id: a,
            drawable: {
                min: 0,
                max: GetNumberOfPedDrawableVariations(e, a) - 1
            },
            texture: {
                min: 0,
                max: GetNumberOfPedTextureVariations(e, a, o) - 1
            },
            blacklist: t
        }
    }

    function X(e, a) {
        let o = GetPedPropIndex(e, a);
        return {
            prop_id: a,
            drawable: {
                min: -1,
                max: GetNumberOfPedPropDrawableVariations(e, a) - 1
            },
            texture: {
                min: -1,
                max: GetNumberOfPedPropTextureVariations(e, a, o) - 1
            }
        }
    }

    function pe(e, a) {
        let o = xe();
        return {
            style: {
                min: 0,
                max: GetNumberOfPedDrawableVariations(e, 2) - 1
            },
            color: {
                items: o.hair
            },
            highlight: {
                items: o.hair
            },
            texture: {
                min: 0,
                max: GetNumberOfPedTextureVariations(e, 2, a.style) - 1
            }
        }
    }

    function Y() {
        let e = PlayerPedId(),
            a = {
                model: {
                    items: re
                }
            },
            o = {
                items: Fe
            },
            r = O.map(y => Q(e, y)),
            t = D.map(y => X(e, y)),
            i = {
                shapeFirst: {
                    min: 0,
                    max: 45
                },
                shapeSecond: {
                    min: 0,
                    max: 45
                },
                skinFirst: {
                    min: 0,
                    max: 45
                },
                skinSecond: {
                    min: 0,
                    max: 45
                },
                shapeMix: {
                    min: 0,
                    max: 1,
                    factor: .1
                },
                skinMix: {
                    min: 0,
                    max: 1,
                    factor: .1
                }
            },
            l = S.reduce((y, p) => ({
                ...y,
                [p]: {
                    min: -1,
                    max: 1,
                    factor: .1
                }
            }), {}),
            n = xe(),
            s = {
                beard: n.hair,
                eyebrows: n.hair,
                chestHair: n.hair,
                makeUp: n.makeUp,
                blush: n.makeUp,
                lipstick: n.makeUp
            },
            c = k.reduce((y, p, f) => {
                let P = {
                    style: {
                        min: 0,
                        max: GetPedHeadOverlayNum(f) - 1
                    },
                    opacity: {
                        min: 0,
                        max: 1,
                        factor: .1
                    }
                };
                return s[p] && Object.assign(P, {
                    color: {
                        items: s[p]
                    }
                }), {
                    ...y,
                    [p]: P
                }
            }, {}),
            d = {
                style: {
                    min: 0,
                    max: GetNumberOfPedDrawableVariations(e, 2) - 1
                },
                color: {
                    items: n.hair
                },
                highlight: {
                    items: n.hair
                },
                texture: {
                    min: 0,
                    max: GetNumberOfPedTextureVariations(e, 2, GetPedDrawableVariation(e, 2)) - 1
                }
            };
        return {
            ped: a,
            components: r,
            props: t,
            headBlend: i,
            faceFeatures: l,
            headOverlays: c,
            hair: d,
            eyeColor: {
                min: 0,
                max: 30
            },
            tattoos: o
        }
    }

    function ue() {
        return oe
    }

    function ee(e) {
        if (C) return;
        e !== "current" && (w = e);
        let {
            coords: a,
            point: o
        } = Ce[w], r = b ? -1 : 1;
        if (m) {
            let t = h(GetOffsetFromEntityInWorldCoords(PlayerPedId(), a.x * r, a.y * r, a.z)),
                i = h(GetOffsetFromEntityInWorldCoords(PlayerPedId(), o.x, o.y, o.z)),
                l = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", t.x, t.y, t.z, 0, 0, 0, 50, !1, 0);
            PointCamAtCoord(l, i.x, i.y, i.z), SetCamActiveWithInterp(l, m, 1e3, 1, 1), C = !0;
            let n = setInterval(() => {
                !IsCamInterpolating(m) && IsCamActive(l) && (DestroyCam(m, !1), m = l, C = !1, clearInterval(n))
            }, 500)
        } else {
            let t = h(GetOffsetFromEntityInWorldCoords(PlayerPedId(), a.x, a.y, a.z)),
                i = h(GetOffsetFromEntityInWorldCoords(PlayerPedId(), o.x, o.y, o.z));
            m = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", t.x, t.y, t.z, 0, 0, 0, 50, !1, 0), PointCamAtCoord(m, i.x, i.y, i.z), SetCamActive(m, !0)
        }
    }
    async function me(e) {
        if (C) return;
        let {
            coords: a,
            point: o
        } = Ce[w], r = Ee[w], t, i = b ? -1 : 1;
        e === "left" ? t = 1 : e === "right" && (t = -1);
        let l = h(GetOffsetFromEntityInWorldCoords(PlayerPedId(), (a.x + r.x) * t * i, (a.y + r.y) * i, a.z)),
            n = h(GetOffsetFromEntityInWorldCoords(PlayerPedId(), o.x, o.y, o.z)),
            s = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", l.x, l.y, l.z, 0, 0, 0, 50, !1, 0);
        PointCamAtCoord(s, n.x, n.y, n.z), SetCamActiveWithInterp(s, m, 1e3, 1, 1), C = !0;
        let c = setInterval(() => {
            !IsCamInterpolating(m) && IsCamActive(s) && (DestroyCam(m, !1), m = s, C = !1, clearInterval(c))
        }, 500)
    }

    function B(e, a) {
        b = !b;
        let o = OpenSequenceTask() ?? 0;
        o !== 0 && (TaskGoStraightToCoord(0, E.x, E.y, E.z, 8, -1, GetEntityHeading(e) - a, .1), TaskStandStill(0, -1), CloseSequenceTask(o), ClearPedTasks(e), TaskPerformSequence(e, o), ClearSequenceTask(o))
    }
    async function Pe(e, a) {
        let {
            animations: o,
            props: r
        } = j[a], {
            dict: t,
            anim: i,
            move: l,
            duration: n
        } = o.on, {
            male: s,
            female: c
        } = r, {
            components: d
        } = e, u = PlayerPedId(), y = g(u);
        for (RequestAnimDict(t); !HasAnimDictLoaded(t);) await F(0);
        if (y)
            for (let p = 0; p < s.length; p++) {
                let [f] = s[p];
                for (let P = 0; P < d.length; P++) {
                    let {
                        component_id: W,
                        drawable: K,
                        texture: q
                    } = d[P];
                    W === f && SetPedComponentVariation(u, f, K, q, 2)
                }
            } else
                for (let p = 0; p < c.length; p++) {
                    let [f] = c[p];
                    for (let P = 0; P < d.length; P++) {
                        let {
                            component_id: W,
                            drawable: K,
                            texture: q
                        } = d[P];
                        W === f && SetPedComponentVariation(u, f, K, q, 2)
                    }
                }
        TaskPlayAnim(u, t, i, 3, 3, n, l, 0, !1, !1, !1)
    }
    async function ve(e) {
        let {
            animations: a,
            props: o
        } = j[e], {
            dict: r,
            anim: t,
            move: i,
            duration: l
        } = a.off, {
            male: n,
            female: s
        } = o, c = PlayerPedId(), d = g(c);
        for (RequestAnimDict(r); !HasAnimDictLoaded(r);) await F(0);
        if (d)
            for (let u = 0; u < n.length; u++) {
                let [y, p] = n[u];
                SetPedComponentVariation(c, y, p, 0, 2)
            } else
                for (let u = 0; u < s.length; u++) {
                    let [y, p] = s[u];
                    SetPedComponentVariation(c, y, p, 0, 2)
                }
        TaskPlayAnim(c, r, t, 3, 3, l, i, 0, !1, !1, !1)
    }
    var te = () => He,
        R = (e, a) => {
            He = a;
            let o = g(e);
            ClearPedDecorations(e);
            for (let r in a)
                for (let t = 0; t < a[r].length; t++) {
                    let {
                        collection: i,
                        hashFemale: l,
                        hashMale: n
                    } = a[r][t], s = o ? n : l;
                    AddPedDecorationFromHashes(e, GetHashKey(i), GetHashKey(s))
                }
        },
        fe = (e, a) => {
            let o = g(e);
            ClearPedDecorations(e);
            for (let r in a)
                for (let t = 0; t < a[r].length; t++) {
                    let {
                        collection: i,
                        hashFemale: l,
                        hashMale: n
                    } = a[r][t], s = o ? n : l;
                    AddPedDecorationFromHashes(e, GetHashKey(i), GetHashKey(s))
                }
        },
        ge = (e, a) => {
            let o = g(e);
            ClearPedDecorations(e);
            for (let r in a)
                for (let t = 0; t < a[r].length; t++) {
                    let {
                        collection: i,
                        hashFemale: l,
                        hashMale: n
                    } = a[r][t], s = o ? n : l;
                    AddPedDecorationFromHashes(e, GetHashKey(i), GetHashKey(s))
                }
        },
        he = (e, a, o) => {
            let r = g(e),
                {
                    collection: t,
                    hashFemale: i,
                    hashMale: l
                } = o,
                n = r ? l : i;
            ClearPedDecorations(e), AddPedDecorationFromHashes(e, GetHashKey(t), GetHashKey(n));
            for (let s in a)
                for (let c = 0; c < a[s].length; c++) {
                    let {
                        name: d,
                        collection: u,
                        hashFemale: y,
                        hashMale: p
                    } = a[s][c];
                    if (o.name !== d) {
                        let f = r ? p : y;
                        AddPedDecorationFromHashes(e, GetHashKey(u), GetHashKey(f))
                    }
                }
        };

    function we(e, a = _e) {
        let o = PlayerPedId();
        I = x(o), U = e, oe = a, E = h(GetEntityCoords(o, !0)), Z = GetEntityHeading(o), b = !1, C = !1, ee("default"), SetNuiFocus(!0, !0), SetNuiFocusKeepInput(!1), RenderScriptCams(!0, !1, 0, !0, !0), DisplayRadar(!1), SetEntityInvincible(o, !0), TaskStandStill(o, -1);
        let r = {
            type: "appearance_display",
            payload: {}
        };
        SendNuiMessage(JSON.stringify(r))
    }

    function J(e) {
        RenderScriptCams(!1, !1, 0, !0, !0), DestroyCam(m, !1), DisplayRadar(!0), SetNuiFocus(!1, !1);
        let a = PlayerPedId();
        ClearPedTasksImmediately(a), SetEntityInvincible(a, !1);
        let o = {
            type: "appearance_hide",
            payload: {}
        };
        if (SendNuiMessage(JSON.stringify(o)), !e) ie($());
        else {
            let {
                tattoos: r
            } = e;
            R(a, r)
        }
        U && U(e), U = null, oe = null, I = null, E = null, m = null, w = null, b = null, C = null
    }

    function Re(e) {
        e === GetCurrentResourceName() && (SetNuiFocus(!1, !1), SetNuiFocusKeepInput(!1))
    }

    function Oe() {
        ye(), on("onResourceStop", Re), Ie("startPlayerCustomization", we)
    }
    var be = {
        loadModule: Oe
    };
    var _ = global.exports,
        De = "0x2746bd9d88c5c5d0",
        Fe = JSON.parse(LoadResourceFile(GetCurrentResourceName(), "tattoos.json")),
        re = JSON.parse(LoadResourceFile(GetCurrentResourceName(), "peds.json")),
        ae = JSON.parse(LoadResourceFile(GetCurrentResourceName(), "blacklist.json")),
        Be = re.reduce((e, a) => ({
            ...e,
            [GetHashKey(a)]: a
        }), {});

    function Se(e) {
        return Be[GetEntityModel(e)]
    }

    function ke(e) {
        let a = [];
        return O.forEach(o => {
            a.push({
                component_id: o,
                drawable: GetPedDrawableVariation(e, o),
                texture: GetPedTextureVariation(e, o)
            })
        }), a
    }

    function Me(e) {
        let a = [];
        return D.forEach(o => {
            a.push({
                prop_id: o,
                drawable: GetPedPropIndex(e, o),
                texture: GetPedPropTextureIndex(e, o)
            })
        }), a
    }

    function Ge(e) {
        let a = new ArrayBuffer(80);
        global.Citizen.invokeNative(De, e, new Uint32Array(a));
        let {
            0: o,
            2: r,
            6: t,
            8: i
        } = new Uint32Array(a), {
            0: l,
            2: n
        } = new Float32Array(a, 48), s = parseFloat(l.toFixed(1)), c = parseFloat(n.toFixed(1));
        return {
            shapeFirst: o,
            shapeSecond: r,
            skinFirst: t,
            skinSecond: i,
            shapeMix: s,
            skinMix: c
        }
    }

    function Ne(e) {
        return S.reduce((o, r, t) => {
            let i = parseFloat(GetPedFaceFeature(e, t).toFixed(1));
            return {
                ...o,
                [r]: i
            }
        }, {})
    }

    function Te(e) {
        return k.reduce((o, r, t) => {
            let [, i, , l, n, s] = GetPedHeadOverlayData(e, t), c = i !== 255, d = c ? i : 0, u = c ? parseFloat(s.toFixed(1)) : 0, y;
            return r === "makeUp" ? y = {
                style: d,
                opacity: u,
                color: l,
                secondColor: n
            } : y = {
                style: d,
                opacity: u,
                color: l
            }, {
                ...o,
                [r]: y
            }
        }, {})
    }

    function Ae(e) {
        return {
            style: GetPedDrawableVariation(e, 2),
            color: GetPedHairColor(e),
            highlight: GetPedHairHighlightColor(e),
            texture: GetPedTextureVariation(e, 2)
        }
    }

    function x(e) {
        let a = GetPedEyeColor(e);
        return {
            model: Se(e) || "mp_m_freemode_01",
            headBlend: Ge(e),
            faceFeatures: Ne(e),
            headOverlays: Te(e),
            components: ke(e),
            props: Me(e),
            hair: Ae(e),
            eyeColor: a < de.length ? a : 0,
            tattoos: te()
        }
    }
    async function L(e) {
        if (!e || !IsModelInCdimage(e)) return;
        for (RequestModel(e); !HasModelLoaded(e);) await F(0);
        let [a, o] = se();
        SetPlayerModel(PlayerId(), e), SetModelAsNoLongerNeeded(e);
        let r = PlayerPedId();
        H(r) && (SetPedDefaultComponentVariation(r), SetPedHeadBlendData(r, 0, 0, 0, 0, 0, 0, 0, 0, 0, !1)), ce(a, o)
    }

    function M(e, a) {
        if (!a) return;
        let {
            shapeFirst: o,
            shapeSecond: r,
            shapeMix: t,
            skinFirst: i,
            skinSecond: l,
            skinMix: n
        } = a;
        H(e) && SetPedHeadBlendData(e, o, r, 0, i, l, 0, t, n, 0, !1)
    }

    function G(e, a) {
        !a || S.forEach((o, r) => {
            let t = a[o];
            SetPedFaceFeature(e, r, t)
        })
    }

    function N(e, a) {
        !a || k.forEach((o, r) => {
            let t = a[o];
            if (SetPedHeadOverlay(e, r, t.style, t.opacity), t.color || t.color === 0) {
                let l = 1;
                var i = t.color;
                ({
                    blush: !0,
                    lipstick: !0,
                    makeUp: !0
                })[o] && (l = 2), o === "makeUp" && (i = t.secondColor), SetPedHeadOverlayColor(e, r, l, t.color, i)
            }
        })
    }

    function T(e, a) {
        if (!a) return;
        let {
            style: o,
            color: r,
            highlight: t,
            texture: i
        } = a;
        SetPedComponentVariation(e, 2, o, i, 2), SetPedHairColor(e, r, t)
    }

    function A(e, a) {
        !a || SetPedEyeColor(e, a)
    }

    function z(e, a) {
        if (!a) return;
        let {
            component_id: o,
            drawable: r,
            texture: t
        } = a;
        ({
            0: !0,
            2: !0
        })[o] && H(e) || SetPedComponentVariation(e, o, r, t, 0)
    }

    function ne(e, a) {
        !a || a.forEach(o => z(e, o))
    }

    function V(e, a) {
        if (!a) return;
        let {
            prop_id: o,
            drawable: r,
            texture: t
        } = a;
        r === -1 ? ClearPedProp(e, o) : SetPedPropIndex(e, o, r, t, !1)
    }

    function le(e, a) {
        !a || a.forEach(o => V(e, o))
    }
    async function ie(e) {
        if (!e) return;
        let {
            model: a,
            components: o,
            props: r,
            headBlend: t,
            faceFeatures: i,
            headOverlays: l,
            hair: n,
            eyeColor: s,
            tattoos: c
        } = e;
        await L(a);
        let d = PlayerPedId();
        ne(d, o), le(d, r), t && M(d, t), i && G(d, i), l && N(d, l), n && T(d, n), s && A(d, s), c && R(d, c)
    }

    function Le(e, a) {
        if (!a) return;
        let {
            components: o,
            props: r,
            headBlend: t,
            faceFeatures: i,
            headOverlays: l,
            hair: n,
            eyeColor: s,
            tattoos: c
        } = a;
        ne(e, o), le(e, r), t && M(e, t), i && G(e, i), l && N(e, l), n && T(e, n), s && A(e, s), c && R(e, c)
    }

    function ze() {
        be.loadModule(), _("getPedModel", Se), _("getPedComponents", ke), _("getPedProps", Me), _("getPedHeadBlend", Ge), _("getPedFaceFeatures", Ne), _("getPedHeadOverlays", Te), _("getPedHair", Ae), _("getPedTattoos", te), _("getPedAppearance", x), _("setPlayerModel", L), _("setPedHeadBlend", M), _("setPedFaceFeatures", G), _("setPedHeadOverlays", N), _("setPedHair", T), _("setPedEyeColor", A), _("setPedComponent", z), _("setPedComponents", ne), _("setPedProp", V), _("setPedProps", le), _("setPedTattoos", R), _("setPlayerAppearance", ie), _("setPedAppearance", Le)
    }
    ze();
})();